import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/station/controller/station_controller.dart';

class StationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StationController>(() => StationController());
  }
}
