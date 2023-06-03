import 'package:flutter/material.dart';

class SignupField extends StatelessWidget {
  
  const SignupField(
    this.customLabelText, {
    super.key,
    required this.valueController,
    this.obscureText = false,
    this.keyboardType = TextInputType.text
  });
  final String customLabelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController valueController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: valueController,
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
