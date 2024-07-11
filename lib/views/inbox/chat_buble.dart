// import 'package:flutter/material.dart';
// import 'package:umoja/models/message_model.dart';
// import 'package:umoja/views/inbox/chat.dart';

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
//           child: Column(
//             crossAxisAlignment:
//                 isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//             children: [
//               if (message.type == MessageType.image)
//                 Image.network(
//                   message.message,
//                   width: 200,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               if (message.type == MessageType.text)
//                 Text(
//                   message.message,
//                   style: const TextStyle(fontSize: 16.0),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }