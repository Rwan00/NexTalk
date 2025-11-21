import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/providers/chat_page_provider.dart';

import 'package:nextalk/theme/app_colors.dart';

import 'package:nextalk/widgets/chats_list_view.dart';

import 'package:nextalk/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late ChatsPageProvider _chatsPageProvider;
  
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth),
        ),
      ],
      child: Builder(
        builder: (context) {
          _chatsPageProvider = context.watch<ChatsPageProvider>();
          List<ChatModel>? chats = _chatsPageProvider.chats;
          log(chats.toString());
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03,
              vertical: _deviceHeight * 0.02,
            ),
            height: _deviceHeight * 0.98,
            width: _deviceWidth * 0.97,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(
                  title: "Chats",
                  primaryAction: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout_outlined,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),

                ChatsListView(chats: chats, deviceHeight: _deviceHeight),
              ],
            ),
          );
        },
      ),
    );
  }
}
