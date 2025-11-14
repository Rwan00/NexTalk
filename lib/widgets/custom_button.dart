import 'package:flutter/material.dart';
import 'package:nextalk/theme/app_colors.dart';
import 'package:nextalk/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;
  const CustomButton({
    super.key,
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.25),
        color: AppColors.kPrimaryColor,
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(name, style: AppTextStyles.textStyle18WhiteBold),
      ),
    );
  }
}
