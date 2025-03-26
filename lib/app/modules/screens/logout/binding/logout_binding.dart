import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutController>(() => LogoutController());
  }
}
