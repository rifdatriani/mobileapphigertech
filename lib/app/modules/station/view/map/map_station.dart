import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationMap extends StatelessWidget {
  const StationMap({super.key});

  static const LatLng _defaultCenter = LatLng(-2.5489, 118.0149); // Indonesia tengah

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _defaultCenter,
            zoom: 4,
          ),
          zoomControlsEnabled: true,
          myLocationEnabled: false, // Hemat resource & cepat tampil
          onMapCreated: (GoogleMapController controller) {
            // Kosong karena controllernya kamu sudah handle sendiri
          },
        ),
      ),
    );
  }
}
