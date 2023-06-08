import 'package:facilitaifpiapp/models/state_model.dart';
import 'package:flutter/material.dart';

class StateTile extends StatelessWidget {
  const StateTile({required this.stateModel, super.key});
  final StateModel stateModel;

  @override
  Widget build(BuildContext context) {
    final avatar = stateModel.avatarUrl == null || stateModel.avatarUrl!.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.add_a_photo),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(stateModel.avatarUrl!),
          );
    return ListTile(
      leading: avatar,
      title: Text(stateModel.name!),
      subtitle: Text(stateModel.abbreviation!),
      trailing: const SizedBox(),
    );
  }
}
