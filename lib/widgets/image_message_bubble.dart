import 'package:flutter/material.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/app_custom_image_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class ImageMessageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final ChatMessageModel message;
  final double height;
  final double width;
  const ImageMessageBubble({
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
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.kPrimaryColor),
        gradient: LinearGradient(
          colors: colorScheme,
          stops: [0.30, 0.70],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isOwnMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          AppCustomImageView(
            height: height,
            width: width,
            imagePath: message.content,
            fit: BoxFit.fill,
            radius: BorderRadius.circular(20),
          ),
          Align(
            alignment: isOwnMessage
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
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
