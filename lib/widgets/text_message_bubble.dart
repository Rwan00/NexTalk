import 'package:flutter/material.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class TextMessageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final ChatMessageModel message;
  final double height;
  final double width;
  const TextMessageBubble({
    super.key,
    required this.isOwnMessage,
    required this.message,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> colorScheme = isOwnMessage
        ? [
            AppColors.kPrimaryColor.withAlpha(50),
            AppColors.kPrimaryColor.withAlpha(100),
          ]
        : [AppColors.kSecondaryColor, AppColors.kSecondaryColor.withAlpha(50)];
    return Container(
      height: height + (message.content.length / 20 * 9.0),
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.kPrimaryColor),
        gradient: LinearGradient(
          colors: colorScheme,
          stops: [0.30, 0.70],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: isOwnMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(message.content),
          Align(
            alignment: isOwnMessage
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: Text(
              timeago.format(message.sentTime),
              style: AppTextStyles.textStyle16GreyBold,
            ),
          ),
        ],
      ),
    );
  }
}
