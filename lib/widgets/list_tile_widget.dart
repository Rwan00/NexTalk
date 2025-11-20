import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nextalk/models/chat_model.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/rounded_image.dart';

class ListTileWidget extends StatelessWidget {
  final double height;
  final ChatModel chat;

  final Function onTap;
  const ListTileWidget({
    super.key,
    required this.height,

    required this.onTap,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      minVerticalPadding: height * 0.20,
      leading: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentGeometry.bottomRight,
        children: [
          RoundedImage(imagePath: chat.imageUrl(), size: height / 2),
          Container(
            height: (height / 2) * 0.20,
            width: (height / 2) * 0.20,
            decoration: BoxDecoration(
              color: chat.isActivity ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ],
      ),
      title: Text(
        chat.title(),
        style: AppTextStyles.textStyle16GreyBold.copyWith(color: Colors.black),
      ),
      subtitle: chat.isActivity
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: AppColors.kPrimaryColor,
                  size: height * 0.10,
                ),
              ],
            )
          : Text(
              chat.messages.last.content,
              style: AppTextStyles.textStyle14BlackBold,
            ),
    );
  }
}
