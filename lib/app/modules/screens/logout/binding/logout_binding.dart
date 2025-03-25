import 'package:get/get.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutBinding>(() => LogoutBinding());
  }
}