import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';
import 'package:mobileapphigertech/app/modules/station/repository/station_repository.dart';

class StationController extends GetxController with StateMixin<dynamic> {
  final StationRepository _repository = StationRepository();
  final List<StationModel> stations = [];
  List<StationModel> filteredStations = [];
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    fetchStations();
  }

  void fetchStations() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.fetchStationList();

      filteredStations.clear();
      filteredStations.addAll(data);

      change(null, status: data.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
    update(); // untuk GetBuilder
  }

  void searchStations(String query) {
    searchQuery = query.toLowerCase();
    filteredStations =
        stations.where((s) => s.name.toLowerCase().contains(searchQuery) || s.stationType.toLowerCase().contains(searchQuery)).toList();
    update();
  }
}
