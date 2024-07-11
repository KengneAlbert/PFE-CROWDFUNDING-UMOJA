// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
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

// enum MessageType {
//   text,
//   image,
// }

// extension MessageTypeExtension on MessageType {
//   String get name => describeEnum(this);
// }

// MessageType messageTypeFromString(String type) {
//   return MessageType.values.firstWhere((e) => e.name == type);
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// enum MessageType { text, image, video, audio, location }

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
//       'type': type.toString(),
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       senderId: map['senderId'],
//       message: map['message'],
//       timestamp: (map['timestamp'] as Timestamp).toDate(),
//       type: MessageType.values.byName(map['type']),
//     );
//   }
// }