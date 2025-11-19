import 'package:flutter/material.dart';
import 'package:nextalk/theme/app_text_styles.dart';

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
      onTap: ()=>onTap(),
      minVerticalPadding: height*0.20,
      title: Text(title,style: AppTextStyles.textStyle14BlackBold,),
    );
  }
}
