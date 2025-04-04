import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_grid_widget.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_list_widget.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_map_widget.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/view/logout_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/higertech.png', height: 50),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              if (!Get.isRegistered<LogoutController>()) {
                Get.put(LogoutController()); // Pastikan Controller sudah ada
              }
              Get.dialog(const LogoutView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: const StationMapWidget(),
              ),
            ),
          ),

          const SizedBox(height: 1), // Jarak antara peta dan grid

          // Station Overview Grid
          const StationOverviewGrid(),
          const SizedBox(height: 16), // Jarak antara grid dan list

          // Expanded untuk daftar stasiun agar bisa tampil penuh
          Expanded(
            child: StationListWidget(),
          ),
        ],
      ),
    );
  }
}
