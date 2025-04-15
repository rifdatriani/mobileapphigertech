import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutController controller = Get.find<LogoutController>();

    return AlertDialog(
      title: const Text(
        "Logout",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        "Apakah Anda yakin ingin keluar?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Batal")),
        TextButton(
          onPressed: () {
            controller.logout(); // Logout user
          },
          child: const Text("Keluar", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
