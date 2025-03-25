import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';

class LogoutView extends GetView<LogoutController> {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // UI lebih smooth
      title: const Text(
        "Logout",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        "Apakah Anda yakin ingin keluar?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Batal", style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () {
            controller.logout();
            Get.back(); // Tutup dialog sebelum logout
          },
          child: const Text("Keluar", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
