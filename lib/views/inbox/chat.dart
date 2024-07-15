import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/chat.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/database_service.dart';
import 'package:umoja/services/storage_service.dart';
import 'package:umoja/views/inbox/chat_buble.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MessageType {
  text,
  image,
  video,
  emoji,
}

extension MessageTypeExtension on MessageType {
  String get name => describeEnum(this);
}

MessageType messageTypeFromString(String type) {
  print('type: $type');
  return MessageType.values.firstWhere(
      (e) => e.toString() == type,
      orElse: () => MessageType.text
  );
}

class MessageModel {
  final String senderId;
  final String message;
  final DateTime timestamp;
  final MessageType type;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp,
      'type': type.name,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: messageTypeFromString(map['type']),
    );
  }
}

class ChatScreen extends ConsumerStatefulWidget {
  final String userId;
  final UserModel? user;

  const ChatScreen({Key? key, required this.userId, required this.user})
      : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _imagePicker = ImagePicker();
  final _videoPicker = ImagePicker();
  bool _isEmojiPickerVisible = false;
  VideoPlayerController? _videoController;

  late String _currentUserId;
  List<MessageModel> _messages = [];
  ChatModel? _chat;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentUserId = FirebaseAuth.instance.currentUser!.uid;
    _fetchChat();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.watch(authViewModelProvider);
    final currentUser = authViewModel?.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _chat == null
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(_chat!.chatId)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching messages'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      _messages = snapshot.data!.docs
                          .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
                          .toList()
                          .reversed
                          .toList();

                      return ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return ChatBubble(
                            message: message,
                            isCurrentUser: message.senderId == _currentUserId,
                            videoController: _videoController,
                          );
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final pickedFile = await _imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      _sendMessageWithImage(File(pickedFile.path));
                    }
                  },
                  icon: const Icon(Icons.image),
                ),
                IconButton(
                  onPressed: () async {
                    final pickedFile = await _videoPicker.pickVideo(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      _sendMessageWithVideo(File(pickedFile.path));
                    }
                  },
                  icon: const Icon(Icons.videocam),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEmojiPickerVisible = !_isEmojiPickerVisible;
                    });
                  },
                  icon: const Icon(Icons.emoji_emotions),
                ),
                IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendMessage(_messageController.text);
                      _messageController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          if (_isEmojiPickerVisible)
            EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _sendMessage(emoji.emoji);
                setState(() {
                  _isEmojiPickerVisible = false;
                });
              },
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.arrow_downward),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchChat() async {
    final chatId = _getChatId(widget.userId);
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
        });
      } else {
        _createChat(chatId);
      }
    } catch (e) {
      print('Error fetching chat: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la récupération du chat'),
      ));
    }
  }

  String _getChatId(String userId) {
    if (_currentUserId.compareTo(userId) < 0) {
      return '$_currentUserId-$userId';
    } else {
      return '$userId-$_currentUserId';
    }
  }

  Future<void> _createChat(String chatId) async {
    final chat = ChatModel(
      chatId: chatId,
      userIds: [_currentUserId, widget.userId],
    );
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .set(chat.toMap());
      setState(() {
        _chat = chat;
      });
    } catch (e) {
      print('Error creating chat: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la création du chat'),
      ));
    }
  }

  Future<void> _sendMessage(String message) async {
    if (_chat == null) {
      print('Chat not initialized');
      return;
    }

    final messageModel = MessageModel(
      senderId: _currentUserId,
      message: message,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(_chat!.chatId)
          .collection('messages')
          .add(messageModel.toMap());

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Error sending message: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de l\'envoi du message'),
      ));
    }
  }

  Future<void> _sendMessageWithImage(File image) async {
    _isLoading = true;
    setState(() {});

    final storageService = StorageService(FirebaseStorage.instance);
    try {
      final imageUrl = await storageService.uploadFile(
          image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
      _isLoading = false;
      setState(() {});

      if (_chat == null) {
        print('Chat not initialized');
        return;
      }

      final messageModel = MessageModel(
        senderId: _currentUserId,
        message: imageUrl,
        timestamp: DateTime.now(),
        type: MessageType.image,
      );

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(_chat!.chatId)
          .collection('messages')
          .add(messageModel.toMap());

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Error sending image message: $e');
      _isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de l\'envoi de l\'image'),
      ));
    }
  }

  Future<void> _sendMessageWithVideo(File video) async {
    _isLoading = true;
    setState(() {});

    final storageService = StorageService(FirebaseStorage.instance);
    try {
      final videoUrl = await storageService.uploadFile(
          video, 'chat_videos/${DateTime.now().millisecondsSinceEpoch}');
      _isLoading = false;
      setState(() {});

      if (_chat == null) {
        print('Chat not initialized');
        return;
      }

      final messageModel = MessageModel(
        senderId: _currentUserId,
        message: videoUrl,
        timestamp: DateTime.now(),
        type: MessageType.video,
      );

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(_chat!.chatId)
          .collection('messages')
          .add(messageModel.toMap());

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Error sending video message: $e');
      _isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de l\'envoi de la vidéo'),
      ));
    }
  }

  void _sendEmoji(String emoji) {
    _sendMessage(emoji);
    setState(() {
      _isEmojiPickerVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchChat();
  }
}

class ChatBubble extends StatefulWidget {
  final MessageModel message;
  final bool isCurrentUser;
  final VideoPlayerController? videoController;

  const ChatBubble({Key? key, required this.message, required this.isCurrentUser, this.videoController})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.message.type == MessageType.video) {
      _videoController = VideoPlayerController.network(widget.message.message)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isCurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: widget.isCurrentUser
                ? Colors.blue[200]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.message.type == MessageType.image)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        _extractImageUrl(widget.message.message), // Afficher l'image directement
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                ),
              if (widget.message.type == MessageType.video)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: _videoController != null && _videoController!.value.isInitialized
                          ? AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
              if (widget.message.type == MessageType.emoji)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.message.message,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              if (widget.message.type == MessageType.text)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.message.message,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour extraire l'URL de l'image à partir du lien Firebase Storage
  String _extractImageUrl(String firebaseUrl) {
    if (firebaseUrl.contains("https://firebasestorage.googleapis.com/")) {
      // Supposons que l'URL soit de la forme .../o/chat_images%2F...
      firebaseUrl = firebaseUrl.substring(firebaseUrl.indexOf("/o/chat_images/") + 13); 
      // Supprimer le '?alt=media&token=' et les paramètres qui suivent
      firebaseUrl = firebaseUrl.substring(0, firebaseUrl.indexOf('?')); 
    }
    return firebaseUrl;
  }
}
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/chat.dart';
// import 'package:umoja/models/user_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:umoja/views/inbox/chat_buble.dart';
// import 'package:video_player/video_player.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum MessageType {
//   text,
//   image,
//   video,
//   emoji,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// MessageType messageTypeFromString(String type) {
//   print('type: $type');
//   return MessageType.values.firstWhere(
//       (e) => e.toString() == type,
//       orElse: () => MessageType.text
//   );
// }

// class MessageModel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;
//   final MessageType type;

//   MessageModel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp,
//       'type': type.name,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: messageTypeFromString(map['type']),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final String userId;
//   final UserModel? user;

//   const ChatScreen({Key? key, required this.userId, required this.user})
//       : super(key: key);

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   final _imagePicker = ImagePicker();
//   final _videoPicker = ImagePicker();
//   bool _isEmojiPickerVisible = false;
//   VideoPlayerController? _videoController;

//   late String _currentUserId;
//   List<MessageModel> _messages = [];
//   ChatModel? _chat;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//     _fetchChat();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = ref.watch(authViewModelProvider);
//     final currentUser = authViewModel?.state;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.video_call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _chat == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(_chat!.chatId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Error fetching messages'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       _messages = snapshot.data!.docs
//                           .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
//                           .toList()
//                           .reversed
//                           .toList();

//                       return ListView.builder(
//                         reverse: false,
//                         controller: _scrollController,
//                         itemCount: _messages.length,
//                         itemBuilder: (context, index) {
//                           final message = _messages[index];
//                           return ChatBubble(
//                             message: message,
//                             isCurrentUser: message.senderId == _currentUserId,
//                             videoController: _videoController,
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Form(
//                     key: _formKey,
//                     child: TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithImage(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.image),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _videoPicker.pickVideo(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithVideo(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.videocam),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _isEmojiPickerVisible = !_isEmojiPickerVisible;
//                     });
//                   },
//                   icon: const Icon(Icons.emoji_emotions),
//                 ),
//                 // Assurez-vous que le bouton d'envoi est dans la même rangée
//                 IconButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendMessage(_messageController.text);
//                       _messageController.clear();
//                     }
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//           if (_isEmojiPickerVisible)
//             EmojiPicker(
//               onEmojiSelected: (category, emoji) {
//                 _sendMessage(emoji.emoji);
//                 setState(() {
//                   _isEmojiPickerVisible = false;
//                 });
//               },
//             ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut,
//                 );
//               },
//               child: const Icon(Icons.arrow_downward),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchChat() async {
//     final chatId = _getChatId(widget.userId);
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .get();

//       if (docSnapshot.exists) {
//         setState(() {
//           _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
//         });
//       } else {
//         _createChat(chatId);
//       }
//     } catch (e) {
//       print('Error fetching chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la récupération du chat'),
//       ));
//     }
//   }

//   String _getChatId(String userId) {
//     if (_currentUserId.compareTo(userId) < 0) {
//       return '$_currentUserId-$userId';
//     } else {
//       return '$userId-$_currentUserId';
//     }
//   }

//   Future<void> _createChat(String chatId) async {
//     final chat = ChatModel(
//       chatId: chatId,
//       userIds: [_currentUserId, widget.userId],
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .set(chat.toMap());
//       setState(() {
//         _chat = chat;
//       });
//     } catch (e) {
//       print('Error creating chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la création du chat'),
//       ));
//     }
//   }

//   Future<void> _sendMessage(String message) async {
//     if (_chat == null) {
//       print('Chat not initialized');
//       return;
//     }

//     final messageModel = MessageModel(
//       senderId: _currentUserId,
//       message: message,
//       timestamp: DateTime.now(),
//       type: MessageType.text,
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi du message'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithImage(File image) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final imageUrl = await storageService.uploadFile(
//           image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: imageUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.image,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending image message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de l\'image'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithVideo(File video) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final videoUrl = await storageService.uploadFile(
//           video, 'chat_videos/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: videoUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.video,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending video message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de la vidéo'),
//       ));
//     }
//   }

//   void _sendEmoji(String emoji) {
//     _sendMessage(emoji);
//     setState(() {
//       _isEmojiPickerVisible = false;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchChat();
//   }
// }

// class ChatBubble extends StatefulWidget {
//   final MessageModel message;
//   final bool isCurrentUser;
//   final VideoPlayerController? videoController;

//   const ChatBubble({Key? key, required this.message, required this.isCurrentUser, this.videoController})
//       : super(key: key);

//   @override
//   State<ChatBubble> createState() => _ChatBubbleState();
// }

// class _ChatBubbleState extends State<ChatBubble> {
//   VideoPlayerController? _videoController;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.message.type == MessageType.video) {
//       _videoController = VideoPlayerController.network(widget.message.message)
//         ..initialize().then((_) {
//           setState(() {});
//         });
//     }
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: widget.isCurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: widget.isCurrentUser
//                 ? Colors.blue[200]
//                 : Colors.grey[200],
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (widget.message.type == MessageType.image)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         widget.message.message, // Afficher l'image directement
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               if (widget.message.type == MessageType.video)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: _videoController != null && _videoController!.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: _videoController!.value.aspectRatio,
//                         child: VideoPlayer(_videoController!),
//                       )
//                           : const CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//               if (widget.message.type == MessageType.emoji)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Text(
//                     widget.message.message,
//                     style: const TextStyle(fontSize: 24.0),
//                   ),
//                 ),
//               if (widget.message.type == MessageType.text)
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       widget.message.message,
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/chat.dart';
// import 'package:umoja/models/user_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:umoja/views/inbox/chat_buble.dart';
// import 'package:video_player/video_player.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum MessageType {
//   text,
//   image,
//   video,
//   emoji,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// MessageType messageTypeFromString(String type) {
//   print('type: $type');
//   return MessageType.values.firstWhere(
//       (e) => e.toString() == type,
//       orElse: () => MessageType.text
//   );
// }

// class MessageModel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;
//   final MessageType type;

//   MessageModel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp,
//       'type': type.name,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: messageTypeFromString(map['type']),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final String userId;
//   final UserModel? user;

//   const ChatScreen({Key? key, required this.userId, required this.user})
//       : super(key: key);

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   final _imagePicker = ImagePicker();
//   final _videoPicker = ImagePicker();
//   bool _isEmojiPickerVisible = false;
//   VideoPlayerController? _videoController;

//   late String _currentUserId;
//   List<MessageModel> _messages = [];
//   ChatModel? _chat;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//     _fetchChat();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = ref.watch(authViewModelProvider);
//     final currentUser = authViewModel?.state;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.video_call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _chat == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(_chat!.chatId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Error fetching messages'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       _messages = snapshot.data!.docs
//                           .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
//                           .toList()
//                           .reversed
//                           .toList();

//                       return ListView.builder(
//                         reverse: false,
//                         controller: _scrollController,
//                         itemCount: _messages.length,
//                         itemBuilder: (context, index) {
//                           final message = _messages[index];
//                           return ChatBubble(
//                             message: message,
//                             isCurrentUser: message.senderId == _currentUserId,
//                             videoController: _videoController,
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Form(
//                     key: _formKey,
//                     child: TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithImage(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.image),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _videoPicker.pickVideo(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithVideo(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.videocam),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _isEmojiPickerVisible = !_isEmojiPickerVisible;
//                     });
//                   },
//                   icon: const Icon(Icons.emoji_emotions),
//                 ),
//                 // Assurez-vous que le bouton d'envoi est dans la même rangée
//                 IconButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendMessage(_messageController.text);
//                       _messageController.clear();
//                     }
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//           if (_isEmojiPickerVisible)
//             EmojiPicker(
//               onEmojiSelected: (category, emoji) {
//                 _sendMessage(emoji.emoji);
//                 setState(() {
//                   _isEmojiPickerVisible = false;
//                 });
//               },
//             ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut,
//                 );
//               },
//               child: const Icon(Icons.arrow_downward),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchChat() async {
//     final chatId = _getChatId(widget.userId);
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .get();

//       if (docSnapshot.exists) {
//         setState(() {
//           _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
//         });
//       } else {
//         _createChat(chatId);
//       }
//     } catch (e) {
//       print('Error fetching chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la récupération du chat'),
//       ));
//     }
//   }

//   String _getChatId(String userId) {
//     if (_currentUserId.compareTo(userId) < 0) {
//       return '$_currentUserId-$userId';
//     } else {
//       return '$userId-$_currentUserId';
//     }
//   }

//   Future<void> _createChat(String chatId) async {
//     final chat = ChatModel(
//       chatId: chatId,
//       userIds: [_currentUserId, widget.userId],
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .set(chat.toMap());
//       setState(() {
//         _chat = chat;
//       });
//     } catch (e) {
//       print('Error creating chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la création du chat'),
//       ));
//     }
//   }

//   Future<void> _sendMessage(String message) async {
//     if (_chat == null) {
//       print('Chat not initialized');
//       return;
//     }

//     final messageModel = MessageModel(
//       senderId: _currentUserId,
//       message: message,
//       timestamp: DateTime.now(),
//       type: MessageType.text,
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi du message'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithImage(File image) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final imageUrl = await storageService.uploadFile(
//           image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: imageUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.image,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending image message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de l\'image'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithVideo(File video) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final videoUrl = await storageService.uploadFile(
//           video, 'chat_videos/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: videoUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.video,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending video message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de la vidéo'),
//       ));
//     }
//   }

//   void _sendEmoji(String emoji) {
//     _sendMessage(emoji);
//     setState(() {
//       _isEmojiPickerVisible = false;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchChat();
//   }
// }

// class ChatBubble extends StatefulWidget {
//   final MessageModel message;
//   final bool isCurrentUser;
//   final VideoPlayerController? videoController;

//   const ChatBubble({Key? key, required this.message, required this.isCurrentUser, this.videoController})
//       : super(key: key);

//   @override
//   State<ChatBubble> createState() => _ChatBubbleState();
// }

// class _ChatBubbleState extends State<ChatBubble> {
//   VideoPlayerController? _videoController;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.message.type == MessageType.video) {
//       _videoController = VideoPlayerController.network(widget.message.message)
//         ..initialize().then((_) {
//           setState(() {});
//         });
//     }
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: widget.isCurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: widget.isCurrentUser
//                 ? Colors.blue[200]
//                 : Colors.grey[200],
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (widget.message.type == MessageType.image)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         widget.message.message,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               if (widget.message.type == MessageType.video)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: _videoController != null && _videoController!.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: _videoController!.value.aspectRatio,
//                         child: VideoPlayer(_videoController!),
//                       )
//                           : const CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//               if (widget.message.type == MessageType.emoji)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Text(
//                     widget.message.message,
//                     style: const TextStyle(fontSize: 24.0),
//                   ),
//                 ),
//               if (widget.message.type == MessageType.text)
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       widget.message.message,
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/chat.dart';
// import 'package:umoja/models/user_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:umoja/views/inbox/chat_buble.dart';
// import 'package:video_player/video_player.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum MessageType {
//   text,
//   image,
//   video,
//   emoji,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// MessageType messageTypeFromString(String type) {
//   print('type: $type');
//   return MessageType.values.firstWhere(
//       (e) => e.toString() == type,
//       orElse: () => MessageType.text
//   );
// }

// class MessageModel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;
//   final MessageType type;

//   MessageModel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp,
//       'type': type.name,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: messageTypeFromString(map['type']),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final String userId;
//   final UserModel? user;

//   const ChatScreen({Key? key, required this.userId, required this.user})
//       : super(key: key);

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   final _imagePicker = ImagePicker();
//   final _videoPicker = ImagePicker();
//   bool _isEmojiPickerVisible = false;
//   VideoPlayerController? _videoController;

//   late String _currentUserId;
//   List<MessageModel> _messages = [];
//   ChatModel? _chat;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//     _fetchChat();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = ref.watch(authViewModelProvider);
//     final currentUser = authViewModel?.state;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Color(0xFF13B156)),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.video_call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _chat == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(_chat!.chatId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Error fetching messages'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       _messages = snapshot.data!.docs
//                           .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
//                           .toList()
//                           .reversed
//                           .toList();

//                       return ListView.builder(
//                         reverse: false, 
//                         controller: _scrollController,
//                         itemCount: _messages.length,
//                         itemBuilder: (context, index) {
//                           final message = _messages[index];
//                           return ChatBubble(
//                             message: message,
//                             isCurrentUser: message.senderId == _currentUserId,
//                             videoController: _videoController,
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Form(
//                     key: _formKey,
//                     child: TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithImage(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.image),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _videoPicker.pickVideo(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithVideo(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.videocam),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _isEmojiPickerVisible = !_isEmojiPickerVisible;
//                     });
//                   },
//                   icon: const Icon(Icons.emoji_emotions),
//                 ),
//                 // Assurez-vous que le bouton d'envoi est dans la même rangée
//                 IconButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendMessage(_messageController.text);
//                       _messageController.clear();
//                     }
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//           // if (_isEmojiPickerVisible) EmojiPicker(onEmojiSelected: (emoji) { 
//           //   // Correction de l'erreur
//           //   _sendMessage(emoji.emoji); 
//           // }), // Correction de l'erreur
//           if (_isEmojiPickerVisible)
//             EmojiPicker(
//               onEmojiSelected: (category, emoji) {
//                 _sendMessage(emoji.emoji);
//                 setState(() {
//                   _isEmojiPickerVisible = false;
//                 });
//               },
//             ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut,
//                 );
//               },
//               child: const Icon(Icons.arrow_downward),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchChat() async {
//     final chatId = _getChatId(widget.userId);
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .get();

//       if (docSnapshot.exists) {
//         setState(() {
//           _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
//         });
//       } else {
//         _createChat(chatId);
//       }
//     } catch (e) {
//       print('Error fetching chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la récupération du chat'),
//       ));
//     }
//   }

//   String _getChatId(String userId) {
//     if (_currentUserId.compareTo(userId) < 0) {
//       return '$_currentUserId-$userId';
//     } else {
//       return '$userId-$_currentUserId';
//     }
//   }

//   Future<void> _createChat(String chatId) async {
//     final chat = ChatModel(
//       chatId: chatId,
//       userIds: [_currentUserId, widget.userId],
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .set(chat.toMap());
//       setState(() {
//         _chat = chat;
//       });
//     } catch (e) {
//       print('Error creating chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la création du chat'),
//       ));
//     }
//   }

//   Future<void> _sendMessage(String message) async {
//     if (_chat == null) {
//       print('Chat not initialized');
//       return;
//     }

//     final messageModel = MessageModel(
//       senderId: _currentUserId,
//       message: message,
//       timestamp: DateTime.now(),
//       type: MessageType.text,
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi du message'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithImage(File image) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final imageUrl = await storageService.uploadFile(
//           image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: imageUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.image,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending image message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de l\'image'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithVideo(File video) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final videoUrl = await storageService.uploadFile(
//           video, 'chat_videos/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: videoUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.video,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending video message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de la vidéo'),
//       ));
//     }
//   }

//   void _sendEmoji(String emoji) {
//     _sendMessage(emoji);
//     setState(() {
//       _isEmojiPickerVisible = false;
//     });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchChat();
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isCurrentUser;
//   final VideoPlayerController? videoController;

//   const ChatBubble({Key? key, required this.message, required this.isCurrentUser, this.videoController})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isCurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: isCurrentUser
//                 ? Colors.blue[200]
//                 : Colors.grey[200],
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (message.type == MessageType.image)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         message.message,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               if (message.type == MessageType.video)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: videoController != null && videoController!.value.isInitialized
//                           ? AspectRatio(
//                         aspectRatio: videoController!.value.aspectRatio,
//                         child: VideoPlayer(videoController!),
//                       )
//                           : const CircularProgressIndicator(),
//                     ),
//                   ),
//                 ),
//               if (message.type == MessageType.emoji)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Text(
//                     message.message,
//                     style: const TextStyle(fontSize: 24.0),
//                   ),
//                 ),
//               if (message.type == MessageType.text)
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       message.message,
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/chat.dart';
// import 'package:umoja/models/user_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:umoja/views/inbox/chat_buble.dart';

// enum MessageType {
//   text,
//   image,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// MessageType messageTypeFromString(String type) {
//   print('type: $type');
//   return MessageType.values.firstWhere(
//       (e) => e.toString() == type,
//       orElse: () => MessageType.text
//   );
// }

// class MessageModel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;
//   final MessageType type;

//   MessageModel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp,
//       'type': type.name,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: messageTypeFromString(map['type']),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final String userId;
//   final UserModel? user;

//   const ChatScreen({Key? key, required this.userId, required this.user})
//       : super(key: key);

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   final _imagePicker = ImagePicker();

//   late String _currentUserId;
//   List<MessageModel> _messages = [];
//   ChatModel? _chat;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//     _fetchChat();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = ref.watch(authViewModelProvider);
//     final currentUser = authViewModel?.state;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.video_call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _chat == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(_chat!.chatId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Error fetching messages'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       _messages = snapshot.data!.docs
//                           .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
//                           .toList()
//                           .reversed
//                           .toList();

//                       return ListView.builder(
//                         reverse: false, // Affichage normal du ListView
//                         controller: _scrollController,
//                         itemCount: _messages.length,
//                         itemBuilder: (context, index) {
//                           final message = _messages[index];
//                           return ChatBubble(
//                             message: message,
//                             isCurrentUser: message.senderId == _currentUserId,
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Form(
//                     key: _formKey,
//                     child: TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithImage(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.image),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendMessage(_messageController.text);
//                       _messageController.clear();
//                     }
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut,
//                 );
//               },
//               child: const Icon(Icons.arrow_downward),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchChat() async {
//     final chatId = _getChatId(widget.userId);
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .get();

//       if (docSnapshot.exists) {
//         setState(() {
//           _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
//         });
//       } else {
//         _createChat(chatId);
//       }
//     } catch (e) {
//       print('Error fetching chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la récupération du chat'),
//       ));
//     }
//   }

//   String _getChatId(String userId) {
//     if (_currentUserId.compareTo(userId) < 0) {
//       return '$_currentUserId-$userId';
//     } else {
//       return '$userId-$_currentUserId';
//     }
//   }

//   Future<void> _createChat(String chatId) async {
//     final chat = ChatModel(
//       chatId: chatId,
//       userIds: [_currentUserId, widget.userId],
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .set(chat.toMap());
//       setState(() {
//         _chat = chat;
//       });
//     } catch (e) {
//       print('Error creating chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la création du chat'),
//       ));
//     }
//   }

//   Future<void> _sendMessage(String message) async {
//     if (_chat == null) {
//       print('Chat not initialized');
//       return;
//     }

//     final messageModel = MessageModel(
//       senderId: _currentUserId,
//       message: message,
//       timestamp: DateTime.now(),
//       type: MessageType.text,
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi du message'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithImage(File image) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final imageUrl = await storageService.uploadFile(
//           image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: imageUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.image,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending image message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de l\'image'),
//       ));
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchChat();
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isCurrentUser;

//   const ChatBubble({Key? key, required this.message, required this.isCurrentUser})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isCurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: isCurrentUser
//                 ? Colors.blue[200]
//                 : Colors.grey[200],
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (message.type == MessageType.image)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: SizedBox(
//                     width: 200,
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         message.message,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               if (message.type == MessageType.text)
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       message.message,
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/chat.dart';
// import 'package:umoja/models/user_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:umoja/views/inbox/chat_buble.dart';

// enum MessageType {
//   text,
//   image,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// MessageType messageTypeFromString(String type) {
//   print('type: $type');
//   return MessageType.values.firstWhere(
//       (e) => e.toString() == type,
//       orElse: () => MessageType.text
//   );
// }

// class MessageModel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;
//   final MessageType type;

//   MessageModel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp,
//       'type': type.name,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: messageTypeFromString(map['type']),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final String userId;
//   final UserModel? user;

//   const ChatScreen({Key? key, required this.userId, required this.user})
//       : super(key: key);

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   final _imagePicker = ImagePicker();

//   late String _currentUserId;
//   List<MessageModel> _messages = [];
//   ChatModel? _chat;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//     _fetchChat();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = ref.watch(authViewModelProvider);
//     final currentUser = authViewModel?.state;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.video_call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _chat == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(_chat!.chatId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(child: Text('Error fetching messages'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       _messages = snapshot.data!.docs
//                           .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
//                           .toList()
//                           .reversed
//                           .toList();

//                       return ListView.builder(
//                         reverse: false, // Affichage normal du ListView
//                         controller: _scrollController,
//                         itemCount: _messages.length,
//                         itemBuilder: (context, index) {
//                           final message = _messages[index];
//                           return ChatBubble(
//                             message: message,
//                             isCurrentUser: message.senderId == _currentUserId,
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Form(
//                     key: _formKey,
//                     child: TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithImage(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.image),
//                 ),
//                 // Assurez-vous que le bouton d'envoi est dans la même rangée
//                 IconButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendMessage(_messageController.text);
//                       _messageController.clear();
//                     }
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//           // Déplacer le bouton vers le haut
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0), // Espacement du bouton
//             child: FloatingActionButton(
//               onPressed: () {
//                 _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent, // Défilement au bas
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut,
//                 );
//               },
//               child: const Icon(Icons.arrow_downward),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchChat() async {
//     final chatId = _getChatId(widget.userId);
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .get();

//       if (docSnapshot.exists) {
//         setState(() {
//           _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
//         });
//       } else {
//         _createChat(chatId);
//       }
//     } catch (e) {
//       print('Error fetching chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la récupération du chat'),
//       ));
//     }
//   }

//   String _getChatId(String userId) {
//     if (_currentUserId.compareTo(userId) < 0) {
//       return '$_currentUserId-$userId';
//     } else {
//       return '$userId-$_currentUserId';
//     }
//   }

//   Future<void> _createChat(String chatId) async {
//     final chat = ChatModel(
//       chatId: chatId,
//       userIds: [_currentUserId, widget.userId],
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .set(chat.toMap());
//       setState(() {
//         _chat = chat;
//       });
//     } catch (e) {
//       print('Error creating chat: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la création du chat'),
//       ));
//     }
//   }

//   Future<void> _sendMessage(String message) async {
//     if (_chat == null) {
//       print('Chat not initialized');
//       return;
//     }

//     final messageModel = MessageModel(
//       senderId: _currentUserId,
//       message: message,
//       timestamp: DateTime.now(),
//       type: MessageType.text,
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending message: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi du message'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithImage(File image) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final imageUrl = await storageService.uploadFile(
//           image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: imageUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.image,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       print('Error sending image message: $e');
//       _isLoading = false;
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de l\'image'),
//       ));
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchChat();
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isCurrentUser;

//   const ChatBubble({Key? key, required this.message, required this.isCurrentUser})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isCurrentUser ? Alignment.bottomRight : Alignment.bottomLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: isCurrentUser
//                 ? Colors.blue[200]
//                 : Colors.grey[200],
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min, 
//             crossAxisAlignment: CrossAxisAlignment.start, 
//             children: [
//               // Affichage de l'image uniquement si le type est 'image'
//               if (message.type == MessageType.image)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0), 
//                   child: SizedBox(
//                     width: 200, 
//                     height: 200, 
//                     child: ClipRRect( 
//                       borderRadius: BorderRadius.circular(16.0),
//                       child: Image.network(
//                         message.message,
//                         fit: BoxFit.cover, 
//                       ),
//                     ),
//                   ),
//                 ),
//               // Affichage du texte uniquement si le type est 'text'
//               if (message.type == MessageType.text)
//                 Expanded( 
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       message.message,
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:umoja/main.dart';
// import 'package:umoja/models/chat.dart';
// import 'package:umoja/models/user_model.dart';
// import 'package:umoja/services/database_service.dart';
// import 'package:umoja/services/storage_service.dart';
// import 'package:umoja/views/inbox/chat_buble.dart';

// enum MessageType {
//   text,
//   image,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// // Corrigé: la méthode firstWhere renvoie une erreur si aucun élément ne correspond
// MessageType messageTypeFromString(String type) {
//   print('type: $type');
//   return MessageType.values.firstWhere(
//       (e) => e.toString() == type,
//       orElse: () => MessageType.text // Valeur par défaut si aucun élément ne correspond
//   );
// }

// class MessageModel {
//   final String senderId;
//   final String message;
//   final DateTime timestamp;
//   final MessageType type;

//   MessageModel({
//     required this.senderId,
//     required this.message,
//     required this.timestamp,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'message': message,
//       'timestamp': timestamp,
//       'type': type.name,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: messageTypeFromString(map['type']),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final String userId;
//   final UserModel? user;

//   const ChatScreen({Key? key, required this.userId, required this.user})
//       : super(key: key);

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   // Corrigé: initialisation du ScrollController en dehors du build
//   final _scrollController = ScrollController();
//   final _imagePicker = ImagePicker();

//   late String _currentUserId;
//   List<MessageModel> _messages = [];
//   ChatModel? _chat;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//     _fetchChat();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     // Corrigé: libération du ScrollController
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = ref.watch(authViewModelProvider);
//     final currentUser = authViewModel?.state;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user?.name ?? widget.user?.email ?? 'Chat'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.video_call),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.call),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _chat == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chats')
//                         .doc(_chat!.chatId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         // Gestion des erreurs
//                         return const Center(child: Text('Error fetching messages'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       _messages = snapshot.data!.docs
//                           .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
//                           .toList()
//                           .reversed
//                           .toList();

//                       return ListView.builder(
//                         reverse: true,
//                         controller: _scrollController, // Attachement du ScrollController
//                         itemCount: _messages.length,
//                         itemBuilder: (context, index) {
//                           final message = _messages[index];
//                           return ChatBubble(
//                             message: message,
//                             isCurrentUser: message.senderId == _currentUserId,
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Form(
//                     key: _formKey,
//                     child: TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final pickedFile = await _imagePicker.pickImage(
//                       source: ImageSource.gallery,
//                     );
//                     if (pickedFile != null) {
//                       _sendMessageWithImage(File(pickedFile.path));
//                     }
//                   },
//                   icon: const Icon(Icons.image),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendMessage(_messageController.text);
//                       _messageController.clear();
//                     }
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _fetchChat() async {
//     final chatId = _getChatId(widget.userId);
//     try {
//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .get();

//       if (docSnapshot.exists) {
//         setState(() {
//           _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
//         });
//       } else {
//         _createChat(chatId);
//       }
//     } catch (e) {
//       // Gestion des erreurs
//       print('Error fetching chat: $e');
//       // Affichage d'une erreur à l'utilisateur
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la récupération du chat'),
//       ));
//     }
//   }

//   String _getChatId(String userId) {
//     if (_currentUserId.compareTo(userId) < 0) {
//       return '$_currentUserId-$userId';
//     } else {
//       return '$userId-$_currentUserId';
//     }
//   }

//   Future<void> _createChat(String chatId) async {
//     final chat = ChatModel(
//       chatId: chatId,
//       userIds: [_currentUserId, widget.userId],
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .set(chat.toMap());
//       setState(() {
//         _chat = chat;
//       });
//     } catch (e) {
//       // Gestion des erreurs
//       print('Error creating chat: $e');
//       // Affichage d'une erreur à l'utilisateur
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de la création du chat'),
//       ));
//     }
//   }

//   Future<void> _sendMessage(String message) async {
//     if (_chat == null) {
//       print('Chat not initialized');
//       return;
//     }

//     final messageModel = MessageModel(
//       senderId: _currentUserId,
//       message: message,
//       timestamp: DateTime.now(),
//       type: MessageType.text,
//     );

//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       // Corrigé: faire défiler après l'ajout du message
//       _scrollController.animateTo(
//         0,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       // Gestion des erreurs
//       print('Error sending message: $e');
//       // Affichage d'une erreur à l'utilisateur
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi du message'),
//       ));
//     }
//   }

//   Future<void> _sendMessageWithImage(File image) async {
//     _isLoading = true;
//     setState(() {});

//     final storageService = StorageService(FirebaseStorage.instance);
//     try {
//       final imageUrl = await storageService.uploadFile(
//           image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
//       _isLoading = false;
//       setState(() {});

//       if (_chat == null) {
//         print('Chat not initialized');
//         return;
//       }

//       final messageModel = MessageModel(
//         senderId: _currentUserId,
//         message: imageUrl,
//         timestamp: DateTime.now(),
//         type: MessageType.image,
//       );

//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(_chat!.chatId)
//           .collection('messages')
//           .add(messageModel.toMap());

//       _scrollController.animateTo(
//         0,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } catch (e) {
//       // Gestion des erreurs
//       print('Error sending image message: $e');
//       _isLoading = false;
//       setState(() {});
//       // Affichage d'une erreur à l'utilisateur
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Erreur lors de l\'envoi de l\'image'),
//       ));
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _fetchChat();
//   }
// }