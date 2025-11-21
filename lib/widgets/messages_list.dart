import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';

class MessagesList extends StatelessWidget {
  final List<ChatMessageModel>? chats;
  final double deviceHeight;
  const MessagesList({
    super.key,
    required this.chats,
    required this.deviceHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (chats != null) {
      if (chats!.isNotEmpty) {
        return SizedBox(
          height: deviceHeight * 0.74,
          child: ListView.builder(
            itemCount: chats!.length,
            itemBuilder: (context, index) {
              return Container(child: Text(chats![index].content));
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
