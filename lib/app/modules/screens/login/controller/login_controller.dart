import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isRememberMe = false.obs;

  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username == "admin" && password == "123") {
      Get.snackbar(
        "Success",
        "Login berhasil!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed(
          AppRoute.home,
        ); 
      });
    } else {
      Get.snackbar(
        "Error",
        "Username atau password salah!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
