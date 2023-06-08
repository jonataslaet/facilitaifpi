import 'package:facilitaifpiapp/controllers/city_list_controller.dart';
import 'package:flutter/material.dart';

class CityListView extends StatelessWidget {
  const CityListView({this.stateId, super.key});
  final int? stateId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cidades"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) {
                    return CityListView(stateId: stateId);
                  }),
                );
            },
            icon: const Icon(Icons.update),
          )
        ],
      ),
      body: CityListController(stateId: stateId),
      bottomNavigationBar: Container(
        height: 50.0,
        color: const Color.fromARGB(238, 255, 183, 59),
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text(
              "Voltar para a página home",
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
