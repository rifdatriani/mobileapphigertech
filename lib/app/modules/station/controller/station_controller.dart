import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';
import 'package:mobileapphigertech/app/modules/station/repository/station_repository.dart';

class StationController extends GetxController with StateMixin<dynamic> {
  final StationRepository _repository = StationRepository();
  final List<StationModel> stations = [];
  List<StationModel> filteredStations = [];
  String searchQuery = '';
  var selectedIndex = 0.obs;

  get searchStations => null;

  @override
  void onInit() {
    super.onInit();
    
    // Ambil argument (nama balai) jika ada
    final balaiName = Get.arguments;
    
    fetchStations(balaiName);
  }

  void fetchStations(String? balaiName) async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      stations.clear();
      stations.addAll(data);

      // Filter berdasarkan balai jika ada
      if (balaiName != null) {
        filteredStations = stations
            .where((s) => s.balaiName != null && s.balaiName == balaiName)
            .toList();
      } else {
        filteredStations = List.from(stations);
      }

      change(null, status: filteredStations.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }

    update();
  }

}
