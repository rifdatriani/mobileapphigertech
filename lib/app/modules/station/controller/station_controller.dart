import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';
import 'package:mobileapphigertech/app/modules/station/repository/station_repository.dart';

class StationController extends GetxController with StateMixin<dynamic> {
  final StationRepository _repository = StationRepository();
  final List<StationModel> stations = [];
  List<StationModel> filteredStations = [];
  String searchQuery = '';
  int selectedIndex = 0;
  String? balaiName;
  List<String> organizationCodes = [];
  String selectedOrganizationCode = '';
  List<dynamic> stationTypes = [];


  



  @override
void onInit()  {
  super.onInit();
  final args = Get.arguments as Map<String, dynamic>?;
  balaiName = args?['balaiName'];
  fetchStations().then((_) => updateStationTypesForBalai());
}

  Future <void> fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      stations.clear();
      stations.addAll(data);
      // Ambil list organizationCode unik dari data
      organizationCodes =
          stations
              .map((s) => s.organizationCode?.toString() ?? '')
              .toSet()
              .where((e) => e.isNotEmpty)
              .toList();

      selectedOrganizationCode =
          organizationCodes.isNotEmpty ? organizationCodes.first : '';



      applyFilter();

      change(
        null,
        status:
            filteredStations.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
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
  List<StationModel> tempList =
      balaiName != null
          ? stations.where((s) => s.balaiName == balaiName).toList()
          : List.from(stations);

  if (stationTypes.isNotEmpty) {
    final currentTab = stationTypes[selectedIndex];
    tempList = tempList.where((s) => s.stationType == currentTab).toList();
  }

  filteredStations = tempList;
}




  void updateStationTypesByOrganization(String organizationCode) {
  final filteredByOrg = stations.where((s) => s.organizationCode == organizationCode).toList();

  stationTypes = filteredByOrg
      .map((s) => s.stationType ?? '')
      .toSet()
      .where((e) => e.isNotEmpty)
      .toList();

  update();
}

void updateStationTypesForBalai() {
  final types = stations
      .where((s) => s.balaiName == balaiName)
      .map((s) => s.stationType)
      .whereType<String>()
      .toSet()
      .toList();

  stationTypes = types;
  selectedIndex = 0;
  applyFilter();
  update();
}



}

  const Map<String, String> stationTypeLabels = {
    'PDA': 'Pos Duga Air',
    'AWLR': 'Pos Duga AIr',
    'PCH': 'Pos Curah Hujan',
    'ARR': 'Pos Curah Hujan',
    'AWS': 'Pos Klimatologi',
    'AWLR_ARR': 'Pos Duga Air & Curah Hujan',
    
  };