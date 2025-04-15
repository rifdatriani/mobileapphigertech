import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapphigertech/app/modules/map/controller/map_controller.dart';

class StationMapWidget extends StatefulWidget {
  final double? height;
  final List<Marker>? markers;

  const StationMapWidget({super.key, this.height, this.markers});

  @override
  State<StationMapWidget> createState() => _StationMapWidgetState();
}

class _StationMapWidgetState extends State<StationMapWidget> {
  late GoogleMapController mapController;
  final mapCtrl = MapController();

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  // Inisialisasi dan update tampilan setelah data marker dimuat
  Future<void> _initializeMap() async {
    await mapCtrl.initialize();
    setState(() {}); // Update UI setelah markers selesai dimuat
    _zoomToFitMarkers(); // Zoom ke marker setelah inisialisasi
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapCtrl.setMapController(controller);
  }

  // Fungsi untuk zoom ke marker setelah inisialisasi
  void _zoomToFitMarkers() {
    if (mapCtrl.markers.isNotEmpty) {
      mapCtrl.zoomToFitMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapWidget = mapCtrl.isLoading
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: mapCtrl.center, zoom: 4.5),
            mapType: MapType.satellite,
            markers: {
              ...mapCtrl.markers,
              if (widget.markers != null) ...widget.markers!,
            },
            myLocationEnabled: false,
            zoomControlsEnabled: true,
          );

    // Mengatur ukuran peta berdasarkan parameter height
    if (widget.height != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(height: widget.height, child: mapWidget),
      );
    }

    return SizedBox.expand(child: mapWidget);
  }
}
