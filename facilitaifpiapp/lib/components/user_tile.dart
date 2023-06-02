import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserModel userModel;
  const UserTile(this.userModel, {super.key});

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
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
            ),
            color: Colors.orange,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
            ),
            color: Colors.red,
          ),
        ]),
      ),
    );
  }
}
