import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';
import 'package:mobileapphigertech/app/modules/station/repository/station_repository.dart';

class StationController extends GetxController with StateMixin<dynamic> {
  final StationRepository _repository = StationRepository();
  final List<StationModel> stations = [];
  List<StationModel> filteredStations = [];
  String searchQuery = '';
  int selectedIndex = 0;

  String? balaiName; // 👈 Simpan nama balai di sini

  @override
  void onInit() {
    super.onInit();

    // Simpan argument (nama balai)
    balaiName = Get.arguments;
    fetchStations();
  }

  void fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      stations.clear();
      stations.addAll(data);

      applyFilter(); // 👈 Langsung terapkan filter sesuai selectedIndex + balaiName

      change(null, status: filteredStations.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    update();
  }

  void changeTab(int index) {
    selectedIndex = index;
    applyFilter(); // ⏎ Terapkan filter baru
    update();
  }

  void searchStations(String query) {
    searchQuery = query.toLowerCase();
    applyFilter(); // ⏎ Terapkan filter baru
    update();
  }

  void applyFilter() {
    List<StationModel> tempList = [];

    // Step 1: Filter berdasarkan balai
    if (balaiName != null) {
      tempList = stations.where((s) => s.balaiName == balaiName).toList();
    } else {
      tempList = List.from(stations);
    }

    // Step 2: Filter berdasarkan tab (stationType)
    switch (selectedIndex) {
      case 0:
        tempList = tempList.where((s) => s.stationType == 'AWLR'||s.stationType == 'PDA').toList();
        break;
      case 1:
        tempList = tempList.where((s) => s.stationType == 'ARR'||s.stationType == 'PCH').toList();
        break;
      case 2:
        tempList = tempList.where((s) => s.stationType == 'AWS').toList();
        // SEMUA (tidak difilter)
        break;
        
    }

    filteredStations = tempList;
  }
  
}
