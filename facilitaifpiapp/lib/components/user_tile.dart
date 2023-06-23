import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:flutter/material.dart';

import '../controllers/edit_user_controller.dart';
import '../repositories/user_repository.dart';

class UserTile extends StatelessWidget {
  const UserTile( {required this.userModel, required this.userRepository, super.key});
  final UserModel userModel;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    final avatar = userModel.avatarUrl == null || userModel.avatarUrl!.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(userModel.avatarUrl!),
          );
    return ListTile(
      leading: avatar,
      title: Text(userModel.name!),
      subtitle: Text(userModel.email!),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) {
                  return EditUserController(userId: userModel.userId!);
                }),
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
            color: Colors.orange,
          ),
          IconButton(
            onPressed: () {
              _deleteUser(userModel.userId);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
            ),
            color: Colors.red,
          ),
        ]),
      ),
    );
  }

  Future<void> _deleteUser(int? id) async {
    if (id == null) return;
    await userRepository.deleteUser(id);
  }
}
