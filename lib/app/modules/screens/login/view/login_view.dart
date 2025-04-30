import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/login/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    final size = MediaQuery.of(context).size;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment:
                      isKeyboardOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    if (!isKeyboardOpen || size.height > 600) ...[
                      Image.asset(
                        'assets/hgt.png',
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Silahkan login untuk mengakses aplikasi",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.usernameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.passwordController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => controller.login(),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isRememberMe.value,
                            onChanged: controller.toggleRememberMe,
                            activeColor: Colors.blue,
                          ),
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Powered By\nPT. Higertech Karya Sinergi",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Informasi Versi 1.0.0",
                              style: TextStyle(color: Colors.black), // judul hitam
                            ),
                            content: const Text(
                              "Fitur yang tersedia di versi 1.0.0:\n\n"
                              "• Fitur Login\n"
                              "• Dashboard Awal\n"
                              "• Peta Lokasi Stasiun\n"
                              "• Halaman Pengaturan",
                              style: TextStyle(color: Colors.black), // isi hitam
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "Tutup",
                                  style: TextStyle(color: Colors.black), // tombol hitam
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        "Versi 1.0.0",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
