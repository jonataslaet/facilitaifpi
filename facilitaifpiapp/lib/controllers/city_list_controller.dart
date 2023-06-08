import 'dart:convert';

import 'package:facilitaifpiapp/components/city_tile.dart';
import 'package:facilitaifpiapp/models/city_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityListController extends StatefulWidget {
  const CityListController({super.key, this.stateId});

  final int? stateId;

  @override
  State<CityListController> createState() => _CityListControllerState();
}

class _CityListControllerState extends State<CityListController> {
  List<CityModel> cities = [];
  bool _isLoading = true;
  
  void _loadCities() async {
    try {
      String url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/${widget.stateId}/municipios";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        List jsonResponse = json.decode(res.body);
        setState(() {
          cities = jsonResponse.map((data) =>
            CityModel.fromJson(data)
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
    _loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CityModel>>(
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          throw Exception(snapshot.error);
        }
        return _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: cities.length,
              itemBuilder: ((context, index) => CityTile(
                cityModel: cities.elementAt(index),
              )),
            );
    });
  }
}