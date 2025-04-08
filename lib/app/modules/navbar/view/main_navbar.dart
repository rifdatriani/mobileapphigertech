import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/view/home_view.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_list_widget.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_map_widget.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/view/logout_view.dart';
// import 'package:mobileapphigertech/app/modules/settings/view/settings_view.dart';

import '../controller/navbar_controller.dart';

class MainNavbar extends StatelessWidget {
  MainNavbar({super.key});
  final NavbarController controller = Get.put(NavbarController());

  // AppBar reusable
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset('assets/higertech.png', height: 50),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.redAccent),
          onPressed: () {
            if (!Get.isRegistered<LogoutController>()) {
              Get.put(LogoutController());
            }
            Get.dialog(const LogoutView());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeView(), // Sudah memiliki AppBar sendiri
      Scaffold(
        appBar: buildAppBar(),
        body: const Padding(
          padding: EdgeInsets.only(top: 8.0), // Tambahan agar Card tidak terlalu atas
          child: StationListWidget(showSearch: true),
        ),
      ),
      Scaffold(
        appBar: buildAppBar(),
        body: const Center(child: StationMapWidget()),
      ),
      // Scaffold(
      //   appBar: buildAppBar(),
      //   body: SettingsView(),
      // ),
    ];

    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Instansi"),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: "Peta"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
            ],
          ),
        ));
  }
}
