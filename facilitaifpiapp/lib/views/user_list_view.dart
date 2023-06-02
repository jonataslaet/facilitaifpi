import 'package:facilitaifpiapp/controllers/user_list_controller.dart';
import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
      ),
      body: const UserListController(),
    );
  }
}

