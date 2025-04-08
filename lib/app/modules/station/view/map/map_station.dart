import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationMap extends StatefulWidget {
  final double latitude;
  final double longitude;

  const StationMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  late GoogleMapController _mapController;
  LatLng? _targetPosition;

  @override
  void initState() {
    super.initState();
    _targetPosition = LatLng(widget.latitude, widget.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_targetPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _targetPosition!, zoom: 12),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _targetPosition ?? const LatLng(-2.5489, 118.0149),
          zoom: 4,
        ),
        zoomControlsEnabled: true,
        myLocationEnabled: false,
        onMapCreated: _onMapCreated,
        markers: _targetPosition != null
            ? {
                Marker(
                  markerId: const MarkerId('selectedStation'),
                  position: _targetPosition!,
                  infoWindow: const InfoWindow(title: 'Stasiun Terpilih'),
                ),
              }
            : {},
      ),
    );
  }
}
