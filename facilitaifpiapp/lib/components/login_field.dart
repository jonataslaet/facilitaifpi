import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField(
    this.customLabelText, {
    super.key,
    this.obscureText = false,
    required this.controller
  });
  final String customLabelText;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo deve ser preenchido.';
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 5.0, style: BorderStyle.solid),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 5.0, style: BorderStyle.solid),
        ),
        labelText: customLabelText,
      ),
    );
  }
}
