import 'package:facilitaifpiapp/controllers/states_controller.dart';
import 'package:flutter/material.dart';

class StatesView extends StatelessWidget {
  const StatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estados"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/states'),
            icon: const Icon(Icons.update),
          )
        ],
      ),
      body: const StatesController(),
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
      ),
    );
  }
}
