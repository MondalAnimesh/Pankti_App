import 'package:flutter/material.dart';
import 'package:pankti_app/core/themes/theme_colors.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: ThemeColors.fieldColor,
        filled: true,
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
