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
  final RxList<StationModel> filteredStations =
      <StationModel>[].obs; // Tambahkan ini
  final RxString searchQuery = ''.obs; // Query pencarian

  final List<MarkerModel> allLocations = [];
  List<Marker> markers = [];
  String? filteredType;

  @override
  void onInit() {
    super.onInit();
    fetchStations();
  }

  void fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      data.where((s) => s.latitude != null && s.longitude != null).forEach((s) {
        allLocations.add(
          MarkerModel(
            latitude: double.tryParse(s.latitude.toString()) ?? 0,
            longitude: double.tryParse(s.longitude.toString()) ?? 0,
            type: s.stationType?.toString() ?? 'Unknown',
          ),
        );
      });
      stations.clear();
      stations.addAll(data);
      filteredStations.assignAll(data); // Inisialisasi dengan semua data

      countStation.totalStation = data.length;
      countStation.totalOrganization =
          data.map((s) => s.organizationCode).toSet().length;

      // Hitung total online & offline berdasarkan status station
      countStation.online = data.where((s) => s.status == 'online').length;
      countStation.offline = data.where((s) => s.status == 'offline').length;

      // Hitung jumlah berdasarkan tipe pos
      countStation.totalAwlr = data.where((s) => s.type == 'AWLR').length;
      countStation.totalArr = data.where((s) => s.type == 'ARR').length;
      countStation.totalAws = data.where((s) => s.type == 'AWS').length;

      change(
        null,
        status: data.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    update(); // untuk GetBuilder
    updateMarkers();
  }

  // Fungsi pencarian balai
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

  /* Contoh cara menampilkan Marker */

  void updateMarkers() {
    final filtered =
        (filteredType == null || filteredType!.isEmpty)
            ? allLocations
            : allLocations.where((e) => e.type == filteredType).toList();

    markers =
        filtered
            .map(
              (loc) => Marker(
                markerId: MarkerId('${loc.latitude},${loc.longitude}'),
                position: LatLng(loc.latitude, loc.longitude),
                icon: getMarkerColor(loc.type), // ← custom warna
                infoWindow: InfoWindow(title: loc.type),
              ),
            )
            .toList();

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

  BitmapDescriptor getMarkerColor(String type) {
    switch (type.toUpperCase()) {
      case 'AWLR':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'ARR':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'AWS':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      default:
        return BitmapDescriptor.defaultMarker; // merah
    }
  }
}
