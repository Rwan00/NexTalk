import 'package:flutter/material.dart';
import 'package:nextalk/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final Function(String)? onEditingComplete;
  final IconData? icon;
  final TextEditingController? controller;
  final String? regEx;
  final String hintText;
  final bool obsecureText;
  final String? validatorMessage;
  const CustomTextFormField({
    super.key,
    this.onSaved,
    this.regEx,
    required this.hintText,
    this.obsecureText = false,
    this.validatorMessage = "Invalid Value",
    this.onEditingComplete,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      obscureText: obsecureText,
      onEditingComplete: () => onEditingComplete?.call(controller!.value.text),
      controller: controller,
      validator: regEx == null
          ? null
          : (value) {
              return RegExp(regEx!).hasMatch(value!) ? null : validatorMessage;
            },

      decoration: InputDecoration(
        fillColor: AppColors.kPrimaryColor.withAlpha(20),
        hintText: hintText,
        filled: true,
        hintStyle: TextStyle(color: AppColors.kPrimaryColor),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
