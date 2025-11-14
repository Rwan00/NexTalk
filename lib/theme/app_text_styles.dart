import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextalk/theme/app_colors.dart';

abstract class AppTextStyles {
  static final logoStyle = GoogleFonts.cinzelDecorative(
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );
  static final headingStyle = TextStyle(
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 36,
  );
  static final splashSubStyle = GoogleFonts.lustria(
    color: AppColors.kPrimaryColor,
    fontSize: 22,
  );
  static final textStyle18PrimaryBold = GoogleFonts.abyssinicaSil(
    color: AppColors.kPrimaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const textStyle16GreyBold = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final textStyle14BlackBold = TextStyle(
    color: Colors.black.withValues(alpha: 0.4),
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static final textStyle12Primary = TextStyle(
    color: AppColors.kPrimaryColor,
    fontSize: 12,
  );
  static final textStyle18WhiteBold = TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          );
}
