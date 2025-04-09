import 'package:get/get.dart';
import '../controller/settings_controller.dart';
import '../repository/settings_repository.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingsRepository());
    Get.lazyPut<SettingsController>(() => SettingsController(Get.find()));
  }
}
