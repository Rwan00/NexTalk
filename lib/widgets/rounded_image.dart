


import 'package:flutter/material.dart';

import 'package:nextalk/widgets/app_custom_image_view.dart';

class RoundedImage extends StatelessWidget {
  final String? imagePath;
  final double size;
  const RoundedImage({super.key, required this.imagePath, required this.size});

  @override
  Widget build(BuildContext context) {
    return AppCustomImageView(
      imagePath: imagePath,
      height: size,
      width: size,
      fit: BoxFit.cover,
      radius: BorderRadius.all(Radius.circular(size)),
    );
  }
}
