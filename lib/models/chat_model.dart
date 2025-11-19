import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/models/chat_user_model.dart';

class ChatModel {
  final String uid;
  final String currentUserId;
  final bool isActive;
  final bool isGroup;
  final List<ChatUserModel> members;
  List<ChatMessageModel> messages = [];

  late final List<ChatUserModel> _recepients;

  ChatModel({
    required this.uid,
    required this.currentUserId,
    required this.isActive,
    required this.isGroup,
    required this.members,
  }) {
    _recepients = members.where((i) => i.uid != currentUserId).toList();
  }

  List<ChatUserModel> recepients() {
    return _recepients;
  }

  String title() {
    return !isGroup
        ? _recepients.first.name
        : _recepients.map((user) => user.name).join(", ");
  }

  String imageUrl() {
    return !isGroup
        ? _recepients.first.imageUrl
        : "https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg";
  }
}
