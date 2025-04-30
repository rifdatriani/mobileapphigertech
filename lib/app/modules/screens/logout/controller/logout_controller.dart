import 'package:get/get.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  void logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); 
      Get.offAllNamed(
        AppRoute.login,
      ); 
    } catch (e) {
      print("Error logout: $e");
    }
  }
}
