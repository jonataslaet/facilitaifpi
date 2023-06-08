import 'package:facilitaifpiapp/controllers/user_list_controller.dart';
import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/users'),
            icon: const Icon(Icons.update),
          )
        ],
      ),
      body: const UserListController(),
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
