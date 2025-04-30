import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileapphigertech/app/modules/screens/login/view/login_view.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Konfirmasi Logout"),
            content: const Text("Apakah Anda yakin ingin logout?"),
            actions: [
              TextButton(
                onPressed:
                    () => Get.back(), 
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () async {
                  Get.back(); 
                  await _logout();
                },
                child: const Text("Logout"),
              ),
            ],
          ),
    );
  }

  static Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Get.offAll(() => LoginView());
  }
}
