import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsController extends StatefulWidget {
  const GoogleMapsController({super.key});

  @override
  State<GoogleMapsController> createState() => _GoogleMapsControllerState();
}

class _GoogleMapsControllerState extends State<GoogleMapsController> {
  late GoogleMapController mapController;
  Set<Marker> _marcadores = {};

  final LatLng _center = const LatLng(-5.08921, -42.80165);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mapas'),
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _marcadores,
        ));
  }

  loadMarkers() {
    Set<Marker> marcadoresLocal = {};
    Marker marcadoIfpiCentro = const Marker(
      markerId: MarkerId('IFPI Campus Teresina Central'),
      position: LatLng(-5.088544046019581, -42.81123803149089),
    );
    Marker marcadoIfpiSul = const Marker(
      markerId: MarkerId('IFPI Campus Sul'),
      position: LatLng(-5.101723, -42.813114),
    );
    marcadoresLocal.add(marcadoIfpiCentro);
    marcadoresLocal.add(marcadoIfpiSul);
    setState(() {
      _marcadores = marcadoresLocal;
    });
  }
}
