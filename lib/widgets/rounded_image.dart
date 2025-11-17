import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nextalk/consts/app_images.dart';


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
  image: file != null
      ? FileImage(File(file!.path!))
      : AssetImage(AppImages.userImage) as ImageProvider,
  fit: BoxFit.cover,
),

        borderRadius: BorderRadius.all(Radius.circular(size)),
        // color: AppColors.kPrimaryColor,
      ),
    );
  }
}
