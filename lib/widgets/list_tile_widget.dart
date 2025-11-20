import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/rounded_image.dart';

class ListTileWidget extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;
  const ListTileWidget({
    super.key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isActive,
    required this.isActivity,
    required this.onTap,
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
          RoundedImage(imagePath: imagePath, size: height / 2),
          Container(
            height: (height / 2) * 0.20,
            width: (height / 2) * 0.20,
            decoration: BoxDecoration(
              color: isActive ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ],
      ),
      title: Text(
        title,
        style: AppTextStyles.textStyle16GreyBold.copyWith(color: Colors.black),
      ),
      subtitle: isActivity
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
          : Text(subtitle, style: AppTextStyles.textStyle14BlackBold),
    );
  }
}
