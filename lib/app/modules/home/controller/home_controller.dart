import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/model/count_station_model.dart';
import 'package:mobileapphigertech/app/modules/home/repository/home_repository.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  final HomeRepository _repository = HomeRepository();
  final List<StationModel> stations = [];
  final CountStationModel countStation = CountStationModel();

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
}
