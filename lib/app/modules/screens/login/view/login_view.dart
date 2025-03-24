import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/login/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.usernameController,
              style: TextStyle(color: Colors.black), // Warna teks menjadi hitam
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.black), // Warna label menjadi hitam
              ),
            ),
            TextField(
              controller: controller.passwordController,
              style: TextStyle(color: Colors.black), // Warna teks menjadi hitam
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black), // Warna label menjadi hitam
              ),
              obscureText: true,
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isRememberMe.value,
                    onChanged: controller.toggleRememberMe,
                  ),
                ),
                Text("Remember me", style: TextStyle(color: Colors.black)), // Warna teks menjadi hitam
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.login,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}