import 'package:get/get.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(AppRoute.login);
    });
  }
}
