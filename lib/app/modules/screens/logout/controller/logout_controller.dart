import 'package:get/get.dart';

class LogoutController extends GetxController {
  void logout() {
    // Tambahkan logika logout, misalnya hapus token dan kembali ke halaman login
    Get.offAllNamed('/login'); // Arahkan user ke halaman login setelah logout
  }
}
