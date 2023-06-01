import 'package:flutter/material.dart';

class LogoView extends StatelessWidget {
  const LogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 150.0,
      width: 190.0,
      child: Image.asset('assets/images/logo-ifpi.png'),
    );
  }
}
