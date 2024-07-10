class ChatModel {
  final String chatId;
  final List<String> userIds;

  ChatModel({
    required this.chatId,
    required this.userIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'userIds': userIds,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'],
      userIds: List<String>.from(map['userIds']),
    );
  }
}