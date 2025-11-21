import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/providers/chat_page_provider.dart';
import 'package:nextalk/providers/chat_provider.dart';
import 'package:nextalk/services/navigation_service.dart';
import 'package:nextalk/widgets/top_bar.dart';
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
  late NavigationService _navigationService;
  late ChatsPageProvider _chatsPageProvider;
  late ChatProvider _chatProvider;

  @override
  void initState() {
    super.initState();
    _messageFormState = GlobalKey<FormState>();
    _messageScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigationService = GetIt.instance.get<NavigationService>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(
            _auth,
            _messageScrollController,
            widget.chatModel.uid,
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          _chatProvider = context.watch<ChatProvider>();
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _deviceWidth * 0.03,
                  vertical: _deviceHeight * 0.02,
                ),
                height: _deviceHeight,
                width: _deviceWidth * 0.97,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopBar(
                      title: widget.chatModel.title(),
                      primaryAction: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                      secondaryAction: IconButton(
                        onPressed: () {
                          _navigationService.goBack();
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      fontSize: 22,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
