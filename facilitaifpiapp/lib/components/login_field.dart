import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField(
    this.customLabelText, {
    super.key,
    this.obscureText = false
  });
  final String customLabelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
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
