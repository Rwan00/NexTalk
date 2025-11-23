import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/providers/chats_page_provider.dart';
import 'package:nextalk/providers/chat_provider.dart';
import 'package:nextalk/services/navigation_service.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/widgets/custom_text_form_field.dart';
import 'package:nextalk/widgets/messages_list.dart';
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
                    MessagesList(
                      messages: _chatProvider.messages,
                      deviceHeight: _deviceHeight,
                      deviceWidth: _deviceWidth,
                      auth: _auth,
                      chat: widget.chatModel,
                    ),

                    Container(
                      height: _deviceHeight * 0.06,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(
                        // horizontal: _deviceWidth * 0.04,
                        vertical: _deviceHeight * 0.03,
                      ),
                      child: Form(
                        key: _messageFormState,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: _deviceWidth * 0.7,
                              child: CustomTextFormField(
                                onSaved: (value) {
                                  _chatProvider.message = value;
                                },
                                regEx: r"^(?!\s*$).+",
                                hintText: "Type a message.",
                              ),
                            ),
                            SizedBox(
                              height: _deviceHeight * 0.04,
                              width: _deviceHeight * 0.04,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.send),
                              ),
                            ),
                            SizedBox(
                              height: _deviceHeight * 0.04,
                              width: _deviceHeight * 0.04,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
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
