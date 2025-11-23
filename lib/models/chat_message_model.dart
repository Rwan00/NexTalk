import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { TEXT, IMAGE, UNKNOWN }

class ChatMessageModel {
  final String uid;
  final MessageType type;
  final String content;
  final String senderId;
  final DateTime sentTime;

  ChatMessageModel( {
    required this.type,
    required this.content,
    required this.senderId,
    required this.sentTime,
    required this.uid,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    MessageType messageType;
    switch (json["type"]) {
      case "text":
        messageType = MessageType.TEXT;
      case "image":
        messageType = MessageType.IMAGE;
      default:
        messageType = MessageType.UNKNOWN;
        break;
    }
    return ChatMessageModel(
      type: messageType,
      content: json["content"],
      senderId: json["sender_id"],
      uid: json["uid"],
      sentTime: json["sent_time"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    String messageType;
    switch (type) {
      case MessageType.TEXT:
        messageType = "text";
      case MessageType.IMAGE:
        messageType = "image";
      default:
        messageType = "";
        break;
    }
    return {
      "content": content,
      "type": messageType,
      "sender_id": senderId,
      "uid":uid,
      "sent_time": Timestamp.fromDate(sentTime),
    };
  }
}
