import 'package:flutter/material.dart';
import 'package:nextalk/theme/app_text_styles.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final double? fontSize;
  const TopBar({
    super.key,
    required this.title,
    this.primaryAction,
    this.secondaryAction,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceHeight * 0.10,
      width: deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondaryAction != null) secondaryAction!,
          Text(
            title,
            style: AppTextStyles.textStyle35BlackW800,
            overflow: TextOverflow.ellipsis,
          ),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }
}
