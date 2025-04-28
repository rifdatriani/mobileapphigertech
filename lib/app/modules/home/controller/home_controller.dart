import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapphigertech/app/modules/home/model/count_station_model.dart';
import 'package:mobileapphigertech/app/modules/home/model/marker_model.dart';
import 'package:mobileapphigertech/app/modules/home/repository/home_repository.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  final HomeRepository _repository = HomeRepository();
  final List<StationModel> stations = [];
  final CountStationModel countStation = CountStationModel();
  final RxList<StationModel> filteredStations = <StationModel>[].obs;
  final RxString searchQuery = ''.obs;

  final List<MarkerModel> allLocations = [];
  List<Marker> markers = [];
  String? filteredType;

  // Simpan icon agar tidak load berulang
  late BitmapDescriptor iconAWLR;
  late BitmapDescriptor iconARR;
  late BitmapDescriptor iconAWS;
  late BitmapDescriptor iconKlimatologi;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    // Load semua ikon hanya sekali
    iconAWLR = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/duga.png',
    );
    iconARR = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/curah.png',
    );
    iconAWS = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/pda.png',
    );
    iconKlimatologi = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(5, 5)),
      'assets/klima.png',
    );

    await fetchStations();
  }

  Future<void> fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      allLocations.clear();
      data.where((s) => s.latitude != null && s.longitude != null).forEach((s) {
        allLocations.add(
          MarkerModel(
            latitude: double.tryParse(s.latitude.toString()) ?? 0,
            longitude: double.tryParse(s.longitude.toString()) ?? 0,
            type: s.stationType?.toString() ?? 'Unknown',
            deviceStatus: s.deviceStatus,
          ),
        );
      });

      stations.clear();
      stations.addAll(data);
      filteredStations.assignAll(data);

      countStation.totalStation = data.length;
      countStation.totalOrganization =
          data.map((s) => s.organizationCode).toSet().length;
      countStation.online = data.where((s) => (s.deviceStatus?.toLowerCase() ?? '') == 'online').length;
      countStation.offline = data.where((s) => (s.deviceStatus?.toLowerCase() ?? '') == 'offline').length;

      countStation.totalAwlr = data.where((s) => s.stationType == 'AWLR').length;
      countStation.totalArr = data.where((s) => s.stationType == 'ARR').length;
      countStation.totalAws = data.where((s) => s.stationType == 'AWS').length;


      change(
        null,
        status: data.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    update();
    await updateMarkers();
  }

  void searchBalai(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredStations.assignAll(stations);
    } else {
      filteredStations.assignAll(
        stations.where(
          (station) =>
              station.balaiName != null &&
              station.balaiName!.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  Future<void> updateMarkers() async {
    final filtered = (filteredType == null || filteredType!.isEmpty)
        ? allLocations
        : allLocations.where((e) => e.type == filteredType).toList();

    List<Marker> tempMarkers = [];

    for (var loc in filtered) {
      final icon = _getMarkerIcon(loc.type);
      tempMarkers.add(
        Marker(
          markerId: MarkerId('${loc.latitude},${loc.longitude}'),
          position: LatLng(loc.latitude, loc.longitude),
          icon: icon,
          infoWindow: InfoWindow(
            title: loc.type,
             snippet: (loc.deviceStatus != null && loc.deviceStatus!.isNotEmpty)
                ? 'Status: ${loc.deviceStatus}'
                : 'Status: Unknown',
          ),
        ),
      );
    }

    markers = tempMarkers;
    update();
  }

  void setFilter(String type) {
    filteredType = type;
    updateMarkers();
  }

  void clearFilter() {
    filteredType = null;
    updateMarkers();
  }

  BitmapDescriptor _getMarkerIcon(String type) {
    switch (type.toUpperCase()) {
      case 'AWLR':
        return iconAWLR;
      case 'ARR':
        return iconARR;
      case 'AWS':
        return iconAWS;
      default:
        return iconKlimatologi;
    }
  }
}
