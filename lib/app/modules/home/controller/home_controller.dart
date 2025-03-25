import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/model/count_station_model.dart';
import 'package:mobileapphigertech/app/modules/home/repository/home_repository.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  final HomeRepository _repository = HomeRepository();
  final List<StationModel> stations = [];
  final CountStationModel countStation = CountStationModel();
  final RxList<StationModel> filteredStations = <StationModel>[].obs; // Tambahkan ini
  final RxString searchQuery = ''.obs; // Query pencarian
 
  @override
  void onInit() {
    super.onInit();
    fetchStations();
  }

  void fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      stations.clear();
      stations.addAll(data);
      filteredStations.assignAll(data); // Inisialisasi dengan semua data

      countStation.totalStation = data.length;
      countStation.totalOrganization = data.map((s) => s.organizationCode).toSet().length;

      // Hitung total online & offline berdasarkan status station
      countStation.online = data.where((s) => s.status == 'online').length;
      countStation.offline = data.where((s) => s.status == 'offline').length;

      // Hitung jumlah berdasarkan tipe pos
      countStation.totalAwlr = data.where((s) => s.type == 'AWLR').length;
      countStation.totalArr = data.where((s) => s.type == 'ARR').length;
      countStation.totalAws = data.where((s) => s.type == 'AWS').length;

      change(null, status: data.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    update(); // untuk GetBuilder
  }

  // Fungsi pencarian balai
  void searchBalai(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredStations.assignAll(stations);
    } else {
      filteredStations.assignAll(stations.where((station) =>
          station.balaiName != null &&
          station.balaiName!.toLowerCase().contains(query.toLowerCase())));
    }
  }
}
