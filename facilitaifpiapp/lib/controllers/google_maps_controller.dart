import 'package:facilitaifpiapp/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsController extends StatefulWidget {
  const GoogleMapsController({super.key});

  @override
  State<GoogleMapsController> createState() => _GoogleMapsControllerState();
}

class _GoogleMapsControllerState extends State<GoogleMapsController> {
  UserRepository userRepository = UserRepository();
  bool _isLoading = true;
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  LatLng _center = const LatLng(-5.08921, -42.80165);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void loadMarkers() async {
    final data = await userRepository.getMarkers();
    setState(() {
      _center = const LatLng(37.3117633, -122.125885);
      _markers = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: userRepository.getMarkers(),
      builder: (ctx, snapshot) {
      if (snapshot.hasError) {
        throw Exception(snapshot.error);
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mapas'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/maps'),
              icon: const Icon(Icons.update),
            )
          ],
        ),
        body: _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _markers,
        )
      );
    });
  }
}
