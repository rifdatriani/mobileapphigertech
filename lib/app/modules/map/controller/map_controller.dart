import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapphigertech/app/modules/map/repository/device_marker_pos_repository.dart';
import 'package:mobileapphigertech/app/modules/map/utils/marker_icon_loader.dart';

class MapController {
  final LatLng center = const LatLng(-2.5489, 118.0149);
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  late GoogleMapController _mapController;
  final DeviceMarkerRepository _repository = DeviceMarkerRepository();

  bool get isLoading => _isLoading;
  Set<Marker> get markers => _markers;

  Future<void> initialize() async {
    final iconAWLR = await MarkerIconLoader.load('assets/duga.png');
    final iconARR = await MarkerIconLoader.load('assets/awan.png');

    try {
      final stations = await _repository.fetchDeviceMarkers();

      for (final station in stations) {
        final stationType = (station.type ?? '').toUpperCase();
        final isOnline = station.status.toLowerCase() == 'online';

        // Memilih ikon berdasarkan tipe stasiun dan status online/offline
        final BitmapDescriptor icon = _getMarkerIcon(stationType, isOnline, iconAWLR, iconARR);

        _markers.add(
          Marker(
            markerId: MarkerId(station.id),
            position: LatLng(station.latitude, station.longitude),
            icon: icon,
            infoWindow: InfoWindow(title: station.name.isNotEmpty ? station.name : 'Unnamed Station'),
          ),
        );
      }

      _isLoading = false;
    } catch (e) {
      debugPrint('Failed to fetch markers: $e');
      _isLoading = false;
    }
  }

  // Fungsi untuk memilih ikon berdasarkan tipe stasiun dan status online/offline
  BitmapDescriptor _getMarkerIcon(String stationType, bool isOnline, BitmapDescriptor iconAWLR, BitmapDescriptor iconARR) {
    if (stationType == 'AWLR') {
      return iconAWLR;
    } else if (stationType == 'ARR') {
      return iconARR;
    } else {
      return isOnline
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  void zoomToFitMarkers() {
    if (_markers.isEmpty) return;

    final positions = _markers.map((e) => e.position).toList();
    final bounds = _createLatLngBounds(positions);
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  // Membuat LatLngBounds secara manual
  LatLngBounds _createLatLngBounds(List<LatLng> positions) {
    double south = positions.first.latitude;
    double north = positions.first.latitude;
    double west = positions.first.longitude;
    double east = positions.first.longitude;

    for (final pos in positions) {
      if (pos.latitude < south) south = pos.latitude;
      if (pos.latitude > north) north = pos.latitude;
      if (pos.longitude < west) west = pos.longitude;
      if (pos.longitude > east) east = pos.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }
}
