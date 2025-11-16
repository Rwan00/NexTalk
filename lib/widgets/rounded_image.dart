import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nextalk/consts/app_images.dart';
import 'package:nextalk/theme/app_colors.dart';

class RoundedImage extends StatelessWidget {
  final PlatformFile? file;
  final double size;
  const RoundedImage({super.key, required this.file, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(file?.path ?? AppImages.userImage),
        ),
        borderRadius: BorderRadius.all(Radius.circular(size)),
        // color: AppColors.kPrimaryColor,
      ),
    );
  }
}
