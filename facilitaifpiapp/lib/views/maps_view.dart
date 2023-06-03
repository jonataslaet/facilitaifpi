import 'package:facilitaifpiapp/controllers/google_maps_controller.dart';
import 'package:flutter/material.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GoogleMapsController()
      ),
    );
  }
}