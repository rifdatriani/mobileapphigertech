import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';

class LogoutView extends GetView<LogoutController> {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Pastikan background tetap putih
      title: const Text(
        "Logout",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Warna teks hitam
      ),
      content: const Text(
        "Apakah Anda yakin ingin keluar?",
        style: TextStyle(color: Colors.black), // Warna teks hitam
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(), // Tutup dialog
          child: const Text(
            "Batal",
            style: TextStyle(color: Colors.blue), // Warna teks lebih terlihat
          ),
        ),
        TextButton(
          onPressed: () => controller.logout(),
          child: const Text(
            "Keluar",
            style: TextStyle(color: Colors.red), // Warna teks merah untuk logout
          ),
        ),
      ],
    );
  }
}
