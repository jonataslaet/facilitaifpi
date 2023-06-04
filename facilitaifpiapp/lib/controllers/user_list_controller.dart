import 'package:facilitaifpiapp/components/user_tile.dart';
import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:flutter/material.dart';

import '../repositories/user_repository.dart';

class UserListController extends StatefulWidget {
  const UserListController({
    super.key,
  });

  @override
  State<UserListController> createState() => _UserListControllerState();
}

class _UserListControllerState extends State<UserListController> {
  final userRepository = UserRepository();
  List<UserModel> users = [];

  bool _isLoading = true;

  void _loadUsers() async {
    final data = await userRepository.getUsers();
    setState(() {
      users = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: userRepository.getUsers(),
    builder: (ctx, snapshot) {
      if (snapshot.hasError) {
        throw Exception(snapshot.error);
      }
      return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: ((context, index) => UserTile(
              userModel: users.elementAt(index),
              userRepository: userRepository,
            )),
          );
    });
  }
}
