import 'package:facilitaifpiapp/models/city_model.dart';
import 'package:flutter/material.dart';

class CityTile extends StatelessWidget {
  const CityTile({required this.cityModel, super.key});
  final CityModel cityModel;

  @override
  Widget build(BuildContext context) {
    final avatar = cityModel.avatarUrl == null || cityModel.avatarUrl!.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.add_a_photo),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(cityModel.avatarUrl!),
          );
    return ListTile(
        leading: avatar,
        title: Text(cityModel.name!),
        subtitle: Text(cityModel.cityId.toString()),
        trailing: const SizedBox(),
      );
  }
}
