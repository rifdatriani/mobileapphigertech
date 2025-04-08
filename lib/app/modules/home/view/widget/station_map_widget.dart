import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapphigertech/app/data/model/marker_pos_model.dart';
import 'package:mobileapphigertech/app/data/repository/device_marker_pos_repository.dart';

class StationMapWidget extends StatefulWidget {
  final double height;

  const StationMapWidget({super.key, this.height = 400});

  @override
  State<StationMapWidget> createState() => _StationMapWidgetState();
}

class _StationMapWidgetState extends State<StationMapWidget> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-2.5489, 118.0149); // Tengah Indonesia
  Set<Marker> _markers = {};
  bool _isLoading = true;

  BitmapDescriptor? iconAWLR;
  BitmapDescriptor? iconARR;

  @override
  void initState() {
    super.initState();
    _initCustomIcons();
  }

  Future<void> _initCustomIcons() async {
    iconAWLR = await _getCustomIcon('assets/duga.png', 100, 100);
    iconARR = await _getCustomIcon('assets/awan.png', 100, 100);
    await _fetchMarkersFromApi();
  }

  Future<BitmapDescriptor> _getCustomIcon(String path, int width, int height) async {
    final byteData = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    final frame = await codec.getNextFrame();
    final imageData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(imageData!.buffer.asUint8List());
  }

  Future<void> _fetchMarkersFromApi() async {
    final repository = DeviceMarkerRepository();

    try {
      List<MapMarkerModel> stations = await repository.fetchDeviceMarkers();
      print('Station count: ${stations.length}');
      print('📌 Stations from API:');
      for (var s in stations) {
        print('${s.name} - ${s.latitude}, ${s.longitude}, ${s.type}, ${s.status}');
      }

      final newMarkers = stations.map((station) {
        BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

        final stationType = (station.type ?? '').toUpperCase();

        if (station.status.toLowerCase() == 'online') {
          markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        } else {
          markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
        }

        if (stationType == 'AWLR' && iconAWLR != null) {
          markerIcon = iconAWLR!;
        } else if (stationType == 'ARR' && iconARR != null) {
          markerIcon = iconARR!;
        }

        return Marker(
          markerId: MarkerId(station.id),
          position: LatLng(station.latitude, station.longitude),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: station.name.isNotEmpty ? station.name : 'Unnamed Station',
          ),
        );
      }).toSet();

      if (!mounted) return;

      setState(() {
        _markers = newMarkers;
        _isLoading = false;
      });

      Future.delayed(const Duration(milliseconds: 300), () => _zoomToFitMarkers());
    } catch (e) {
      print('Error fetching station markers: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _zoomToFitMarkers() {
    if (_markers.isEmpty) return;

    final positions = _markers.map((e) => e.position).toList();
    final bounds = _createLatLngBounds(positions);

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _createLatLngBounds(List<LatLng> positions) {
    double south = positions.first.latitude;
    double north = positions.first.latitude;
    double west = positions.first.longitude;
    double east = positions.first.longitude;

    for (var pos in positions) {
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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: widget.height,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 4.5,
                ),
                mapType: MapType.hybrid,
                markers: _markers,
                zoomControlsEnabled: false,
              ),
      ),
    );
  }
}
