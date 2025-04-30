import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/settings_repository.dart';

class SettingsController extends GetxController {
  final SettingsRepository repository;

  SettingsController(this.repository);

  var isDarkMode = false.obs;
  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
  void logout() {
  }
}
