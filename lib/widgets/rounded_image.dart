import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nextalk/consts/app_images.dart';


class RoundedImage extends StatefulWidget {
  final PlatformFile? file;
  final double size;
  const RoundedImage({super.key, required this.file, required this.size});

  @override
  State<RoundedImage> createState() => _RoundedImageState();
}

class _RoundedImageState extends State<RoundedImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.file?.path ?? AppImages.userImage),
        ),
        borderRadius: BorderRadius.all(Radius.circular(widget.size)),
        // color: AppColors.kPrimaryColor,
      ),
    );
  }
}
