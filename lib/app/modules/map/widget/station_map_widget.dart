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
  bool _showLegend = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await mapCtrl.initialize();
    setState(() {});
    _zoomToFitMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapCtrl.setMapController(controller);
  }

  void _zoomToFitMarkers() {
    if (mapCtrl.markers.isNotEmpty) {
      mapCtrl.zoomToFitMarkers();
    }
  }

  Widget _buildLegendCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _legendItem('assets/duga.png', 'Pos Duga Air (PDA/AWLR)'),
          const SizedBox(height: 6),
          _legendItem('assets/awan.png', 'Pos Curah Hujan (PCH/ARR)'),
        ],
      ),
    );
  }

  Widget _legendItem(String assetPath, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(assetPath, width: 24, height: 24),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapWidget = mapCtrl.isLoading
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: mapCtrl.center, zoom: 4.5),
            mapType: MapType.hybrid,
            markers: {
              ...mapCtrl.markers,
              if (widget.markers != null) ...widget.markers!,
            },
            myLocationEnabled: false,
            zoomControlsEnabled: true,
          );

    final mapWithLegend = Stack(
      children: [
        mapWidget,

        // Tombol info (pojok kiri bawah)
        Positioned(
          left: 16,
          bottom: 16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showLegend = !_showLegend;
              });

              if (_showLegend) {
                Future.delayed(const Duration(seconds: 5), () {
                  if (mounted) {
                    setState(() {
                      _showLegend = false;
                    });
                  }
                });
              }
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.info_outline, size: 20, color: Colors.black),
            ),
          ),
        ),

        // Legend card (di atas tombol info)
        Positioned(
          left: 16,
          bottom: 80,
          child: AnimatedOpacity(
            opacity: _showLegend ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: !_showLegend,
              child: _buildLegendCard(),
            ),
          ),
        ),
      ],
    );

    if (widget.height != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(height: widget.height, child: mapWithLegend),
      );
    }

    return SizedBox.expand(child: mapWithLegend);
  }
}
