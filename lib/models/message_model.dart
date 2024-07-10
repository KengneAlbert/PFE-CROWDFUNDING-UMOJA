import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, video, audio, location }

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
      'type': type.toString(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      type: MessageType.values.byName(map['type']),
    );
  }
}