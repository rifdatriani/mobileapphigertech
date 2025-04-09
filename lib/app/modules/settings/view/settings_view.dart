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
        ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text("Mode Gelap"),
          trailing: Obx(() => Switch(
            value: controller.isDarkMode.value,
            onChanged: (val) => controller.toggleDarkMode(),
          )),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text("Keluar"),
          onTap: () {
            if (!Get.isRegistered<LogoutController>()) {
              Get.put(LogoutController());
            }
            Get.dialog(const LogoutView());
          },
        ),
      ],
    );
  }
}
