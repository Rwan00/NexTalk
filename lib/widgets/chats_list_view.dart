import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/pages/chat_page.dart';
import 'package:nextalk/services/navigation_service.dart';

import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/list_tile_widget.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required this.chats,
    required double deviceHeight,
  }) : _deviceHeight = deviceHeight;

  final List<ChatModel>? chats;
  final double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    NavigationService navigation = GetIt.instance.get<NavigationService>();
    return Expanded(
      child: (() {
        if (chats != null) {
          if (chats!.isNotEmpty) {
            return ListView.builder(
              itemCount: chats!.length,
              itemBuilder: (context, index) => ListTileWidget(
                chat: chats![index],
                height: _deviceHeight * 0.10,
                onTap: () {
                  navigation.navigateToPage(ChatPage(chatModel: chats![index]));
                },
              ),
            );
          } else {
            return Text("No Chats Found...", style: AppTextStyles.headingStyle);
          }
        } else {
          return Center(
            child: SpinKitCircle(
              color: AppColors.kPrimaryColor,
              size: _deviceHeight * 0.06,
            ),
          );
        }
      })(),
    );
  }
}
