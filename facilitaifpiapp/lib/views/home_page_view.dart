import 'package:facilitaifpiapp/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
              'App de contatos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      body: const HomePageController(),
      bottomNavigationBar: Container(
        height: 50.0,
        color: const Color.fromARGB(238, 255, 183, 59),
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text(
              "Voltar para a página de login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    );
  }
}
