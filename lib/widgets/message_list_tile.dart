import 'package:flutter/material.dart';
import 'package:nextalk/models/chat_message_model.dart';
import 'package:nextalk/models/chat_user_model.dart';
import 'package:nextalk/widgets/image_message_bubble.dart';
import 'package:nextalk/widgets/text_message_bubble.dart';
import 'package:nextalk/widgets/rounded_image.dart';

class MessageListTile extends StatelessWidget {
  final double width;
  final double height;
  final bool isOwnMessage;
  final ChatMessageModel message;
  final ChatUserModel sender;
  const MessageListTile({
    super.key,
    required this.width,
    required this.height,
    required this.isOwnMessage,
    required this.message,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: width,
      child: Row(
        mainAxisAlignment: isOwnMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !isOwnMessage
              ? RoundedImage(imagePath: sender.imageUrl, size: width * 0.04)
              : Container(),
          SizedBox(width: width * 0.05),
          message.type == MessageType.TEXT
              ? TextMessageBubble(
                  isOwnMessage: isOwnMessage,
                  message: message,
                  height: height * 0.06,
                  width: width,
                )
              : ImageMessageBubble(
                  isOwnMessage: isOwnMessage,
                  message: message,
                  height: height * 0.30,
                  width: width * 0.55,
                ),
        ],
      ),
    );
  }
}
