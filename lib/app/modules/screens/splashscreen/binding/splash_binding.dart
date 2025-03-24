import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/splashscreen/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}