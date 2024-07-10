import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umoja/main.dart';
import 'package:umoja/models/chat.dart';
import 'package:umoja/models/message_model.dart';
import 'package:umoja/models/user_model.dart';
import 'package:umoja/services/database_service.dart';
import 'package:umoja/services/storage_service.dart';
import 'package:umoja/views/inbox/chat_buble.dart';

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

  late String _currentUserId;
  List<MessageModel> _messages = [];
  late ChatModel _chat;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.watch(authViewModelProvider);
    final currentUser = authViewModel?.state!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user!.name ?? widget.user!.email),
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(_chat.chatId)
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
                  reverse: true,
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return ChatBubble(
                      message: message,
                      isCurrentUser: message.senderId == _currentUserId,
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
        ],
      ),
    );
  }

  Future<void> _fetchChat() async {
    final chatId = _getChatId(widget.userId);
    final docSnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .get();

    if (docSnapshot.exists) {
      _chat = ChatModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } else {
      _createChat(chatId);
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
    await FirebaseFirestore.instance.collection('chats').doc(chatId).set(chat.toMap());
    _chat = chat;
  }

  Future<void> _sendMessage(String message) async {
    final messageModel = MessageModel(
      senderId: _currentUserId,
      message: message,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chat.chatId)
        .collection('messages')
        .add(messageModel.toMap());

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _sendMessageWithImage(File image) async {
    _isLoading = true;
    setState(() {});

    final storageService = StorageService(FirebaseStorage.instance);
    final imageUrl = await storageService.uploadFile(image, 'chat_images/${DateTime.now().millisecondsSinceEpoch}');
    _isLoading = false;
    setState(() {});

    final messageModel = MessageModel(
      senderId: _currentUserId,
      message: imageUrl,
      timestamp: DateTime.now(),
      type: MessageType.image,
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chat.chatId)
        .collection('messages')
        .add(messageModel.toMap());

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the chat reference when the dependencies change (e.g., when the chatId changes)
    _fetchChat();
  }
}