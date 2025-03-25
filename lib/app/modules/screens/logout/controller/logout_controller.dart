import 'package:get/get.dart';

class LogoutController extends GetxController {
  void logout() {
    Get.offAllNamed('/login'); // Langsung pindah ke halaman login
  }
}
