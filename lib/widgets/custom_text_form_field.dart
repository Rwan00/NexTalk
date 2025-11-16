import 'package:flutter/material.dart';
import 'package:nextalk/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String? regEx;
  final String hintText;
  final bool obsecureText;
  final String? validatorMessage;
  const CustomTextFormField({
    super.key,
    required this.onSaved,
     this.regEx,
    required this.hintText,
    this.obsecureText = false,
     this.validatorMessage = "Invalid Value",
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => onSaved(value!),
      obscureText: obsecureText,

      validator:regEx== null?null: (value) {
        return RegExp(regEx!).hasMatch(value!) ? null : validatorMessage;
      },
      decoration: InputDecoration(
        fillColor: AppColors.kPrimaryColor.withAlpha(20),
        hintText: hintText,
        filled: true,
        hintStyle: TextStyle(color: AppColors.kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
