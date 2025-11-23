import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/providers/authentication_provider.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/message_list_tile.dart';

class MessagesList extends StatelessWidget {
  final List<ChatMessageModel>? messages;
  final double deviceHeight;
  final double deviceWidth;
  final AuthenticationProvider auth;
  final ChatModel chat;
  final ScrollController scrollController;
  const MessagesList({
    super.key,
    required this.messages,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.auth,
    required this.chat, required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (messages != null) {
      if (messages!.isNotEmpty) {
        return SizedBox(
          height: deviceHeight * 0.74,
          child: ListView.builder(
            controller: scrollController,
            itemCount: messages!.length,
            itemBuilder: (context, index) {
              bool isOwnMessage = messages![index].senderId == auth.chatUser.uid;
              return MessageListTile(
                
                width: deviceWidth * 0.80,
                height: deviceHeight,
                isOwnMessage: isOwnMessage,
                message: messages![index],
                sender:chat.members.where((m)=>m.uid==messages![index].senderId).first,
              );
            },
          ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: Text(
            "No Messages Found...Start The Conversation..",
            style: AppTextStyles.headingStyle,
          ),
        );
      }
    } else {
      return Center(
        child: SpinKitCircle(
          color: AppColors.kPrimaryColor,
          size: deviceHeight * 0.06,
        ),
      );
    }
  }
}
