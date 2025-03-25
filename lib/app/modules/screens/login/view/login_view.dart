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
            Image.asset('assets/hgt.png', width: 100),
                const SizedBox(height: 10),
                const Text(
                  "Silahkan login untuk mengakses aplikasi",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  ),
              child: Text("Login"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Powered By\nPT. Higertech Karya Sinergi",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}