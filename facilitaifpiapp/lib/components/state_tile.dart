import 'package:facilitaifpiapp/models/state_model.dart';
import 'package:facilitaifpiapp/views/city_list_view.dart';
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
      onTap: () { 
        Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext context) {
            return CityListView(stateId: stateModel.stateId!);
          }),
        );
      },
      leading: avatar,
      title: Text(stateModel.name!),
      subtitle: Text(stateModel.abbreviation!),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) {
                    return CityListView(stateId: stateModel.stateId!);
                  }),
                );
              },
              icon: const Icon(
                Icons.view_agenda_outlined,
              ),
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
