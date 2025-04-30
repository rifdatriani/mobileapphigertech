import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
import 'package:mobileapphigertech/app/modules/home/view/home_view.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_list_widget.dart';
import 'package:mobileapphigertech/app/modules/map/widget/station_map_widget.dart';
import 'package:mobileapphigertech/app/modules/settings/controller/settings_controller.dart';
import 'package:mobileapphigertech/app/modules/settings/repository/settings_repository.dart';
import 'package:mobileapphigertech/app/modules/settings/view/settings_view.dart';

import '../controller/navbar_controller.dart';

class MainNavbar extends StatelessWidget {
  MainNavbar({super.key});
  final NavbarController controller = Get.put(NavbarController());

  PreferredSizeWidget buildAppBar(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: size.height * 0.07, 
      title: Image.asset(
        'assets/higertech.png',
        height: size.height * 0.04, 
        fit: BoxFit.contain,
      ),
      centerTitle: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsRepository());
      Get.put(SettingsController(Get.find()));
    }

    final List<Widget> pages = [
      HomeView(), 
      Scaffold(
        appBar: buildAppBar(context),
        body: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: StationListWidget(showSearch: true),
        ),
      ),
      Scaffold(
        appBar: buildAppBar(context),
        body: GetBuilder<HomeController>(
          builder:
              (controller) => StationMapWidget(markers: controller.markers),
        ),
      ),
      Scaffold(appBar: buildAppBar(context), body: SettingsView()),
    ];

    return Obx(
      () => Scaffold(
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
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Pengaturan",
            ),
          ],
        ),
      ),
    );
  }
}
