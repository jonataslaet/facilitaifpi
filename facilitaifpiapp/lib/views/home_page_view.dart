import 'package:flutter/material.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: HomePageController()
      ),
    );
  }
}