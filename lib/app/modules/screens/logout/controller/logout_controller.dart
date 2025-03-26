import 'package:get/get.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  void logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Hapus sesi pengguna
      Get.offAllNamed(AppRoute.login); // Pindah ke halaman login dan hapus semua halaman sebelumnya
    } catch (e) {
      print("Error logout: $e");
    }
  }
}
