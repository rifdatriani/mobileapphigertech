import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';
import 'package:mobileapphigertech/app/modules/station/repository/station_repository.dart';

class StationController extends GetxController with StateMixin<dynamic> {
  final StationRepository _repository = StationRepository();
  final List<StationModel> stations = [];
  List<StationModel> filteredStations = [];
  String searchQuery = '';
  int selectedIndex = 0;
  String? balaiName;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    balaiName = args?['balaiName'];
    fetchStations();
  }

  void fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      stations.clear();
      stations.addAll(data);

      applyFilter();

      change(null, status: filteredStations.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    update();
  }

  void changeTab(int index) {
    selectedIndex = index;
    applyFilter();
    update();
  }

  void searchStations(String query) {
    searchQuery = query.toLowerCase();
    applyFilter();
    update();
  }

  void applyFilter() {
    List<StationModel> tempList = balaiName != null
        ? stations.where((s) => s.balaiName == balaiName).toList()
        : List.from(stations);

    final stationTypes = {
      0: ['AWLR', 'PDA'],
      1: ['ARR', 'PCH'],
      2: ['AWS'],
    };

    final allowedTypes = stationTypes[selectedIndex] ?? [];
    tempList = tempList.where((s) => allowedTypes.contains(s.stationType)).toList();

    filteredStations = tempList;
  }
}
