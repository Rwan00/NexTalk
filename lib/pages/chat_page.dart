import 'package:flutter/material.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/providers/chat_page_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chatModel;
  const ChatPage({super.key, required this.chatModel});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messageScrollController;

  late AuthenticationProvider _auth;
  late ChatsPageProvider _chatsPageProvider;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return  Scaffold();
  }
}
