import 'package:flutter/material.dart';
import 'package:nextalk/models/user_model.dart';
import 'package:nextalk/theme/app_text_styles.dart';
import 'package:nextalk/widgets/rounded_image.dart';

class UserListTileWidget extends StatelessWidget {
  final double height;
  final UserModel user;
  final bool isSelected;
  final Function onTap;
  const UserListTileWidget({
    super.key,
    required this.height,
    required this.user,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: isSelected ? Icon(Icons.check) : null,
      leading: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentGeometry.bottomRight,
        children: [
          RoundedImage(imagePath: user.imageUrl, size: height / 2),
          Container(
            height: (height / 2) * 0.20,
            width: (height / 2) * 0.20,
            decoration: BoxDecoration(
              color: user.wasRecentlyActive() ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ],
      ),
      onTap: () => onTap(),
      minVerticalPadding: height * 0.20,
      title: Text(
        user.name,
        style: AppTextStyles.textStyle16GreyBold.copyWith(color: Colors.black),
      ),
      subtitle: Text(
        "Last Active: ${user.lastDayActive()}",
        style: AppTextStyles.textStyle14BlackBold,
      ),
    );
  }
}
