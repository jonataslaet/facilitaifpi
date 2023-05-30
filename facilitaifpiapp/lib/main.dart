import 'package:facilitaifpiapp/home_page_view.dart';
import 'package:flutter/material.dart';

import 'login_page_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(238, 255, 183, 59),
        ),
        useMaterial3: true,
        fontFamily: 'All Round Gothic',
      ),
      home: const LoginPageController(),
      routes: {
        '/home': (context) => const HomePageView(),
      },
    );
  }
}
