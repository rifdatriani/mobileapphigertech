import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/logout/controller/logout_controller.dart';
import '../../screens/logout/view/logout_view.dart';
import '../controller/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Mode Gelap
        ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text("Mode Gelap"),
          trailing: Obx(() => Switch(
                value: controller.isDarkMode.value,
                onChanged: (val) => controller.toggleDarkMode(),
              )),
        ),

        const Divider(),
        const SizedBox(height: 500),

        // Tombol Logout berbentuk Card Button
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color: Colors.grey[100],
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (!Get.isRegistered<LogoutController>()) {
                Get.put(LogoutController());
              }
              Get.dialog(const LogoutView());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Keluar',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
