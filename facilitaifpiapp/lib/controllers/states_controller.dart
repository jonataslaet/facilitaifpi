import 'dart:convert';

import 'package:facilitaifpiapp/components/state_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/state_model.dart';

class StatesController extends StatefulWidget {
  const StatesController({super.key});

  @override
  State<StatesController> createState() => _StatesControllerState();
}

class _StatesControllerState extends State<StatesController> {
  List<StateModel> states = [];
  bool _isLoading = true;

  void _loadStates() async {
    try {
      String url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        List jsonResponse = json.decode(res.body);
        setState(() {
          states = jsonResponse.map((data) =>
            StateModel.fromJson(data)
          ).toList();
          _isLoading = false;
        });
      }
    }catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStates();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StateModel>>(
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          throw Exception(snapshot.error);
        }
        return _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: states.length,
              itemBuilder: ((context, index) => StateTile(
                stateModel: states.elementAt(index),
              )),
            );
    });
  }
}