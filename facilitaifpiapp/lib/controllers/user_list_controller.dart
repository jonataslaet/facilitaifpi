import 'package:facilitaifpiapp/components/user_tile.dart';
import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:flutter/material.dart';

class UserListController extends StatefulWidget {
  const UserListController({
    super.key,
  });

  @override
  State<UserListController> createState() => _UserListControllerState();
}

class _UserListControllerState extends State<UserListController> {
  List<UserModel> users = [];

  bool _isLoading = true;
  
  void _loadUsers() async {
    final data = await getData();
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
      future: getData(),
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
            itemBuilder: (
              (context, index) => UserTile(
                users.elementAt(index),
              )
            ),
          ) ;
      });
  }

  Future<List<UserModel>> getData() async {
    //TODO: Replace mock users for users found on database
    UserModel user1 = UserModel(userId: 98, email: 'jonataslaet@gmail.com', password: 'sharingan', name: 'Jonatas Laet', avatarUrl: '');
    UserModel user2 = UserModel(userId: 99, email: 'jonataslaet@gmail.com', password: 'sharingan', name: 'Jonatas Laet', avatarUrl: 'https://cdn-icons-png.flaticon.com/128/9071/9071202.png');
    final List<UserModel> response = [user1, user2];
    return response;
  }
}
