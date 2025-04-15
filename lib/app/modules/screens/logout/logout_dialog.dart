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
                    () => Get.back(), // Gunakan GetX untuk menutup dialog
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () async {
                  Get.back(); // Tutup dialog dulu
                  await _logout();
                },
                child: const Text("Logout"),
              ),
            ],
          ),
    );
  }

  static Future<void> _logout() async {
    // Hapus sesi pengguna dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Pindah ke halaman login dan hapus semua halaman sebelumnya
    Get.offAll(() => LoginView());
  }
}
