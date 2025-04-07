import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_map_widget.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/view/logout_view.dart';
import 'package:mobileapphigertech/app/modules/station/controller/station_controller.dart';
import 'package:mobileapphigertech/app/modules/station/view/map/map_station.dart';

class StationView extends GetView<StationController> {
  const StationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil argument dengan aman
    final String balai =
        Get.arguments is Map<String, dynamic>
            ? Get.arguments['balai'] ?? 'Station'
            : Get.arguments?.toString() ?? 'Station';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/higertech.png', height: 50),
        centerTitle: true,
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
          // Nama Balai
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Padding(
              padding: EdgeInsets.all(1.w),
              child: Center(
                child: Text(
                  balai,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          const SizedBox(height: 1),

          // Map Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(height: 200, child: const StationMap()),
            ),
          ),

          const SizedBox(height: 1),

          // Konten lainnya
          Expanded(
            child: GetBuilder<StationController>(
              builder: (controller) {
                if (controller.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.status.isError) {
                  return Center(
                    child: Text('Error: ${controller.status.errorMessage}'),
                  );
                }

                if (controller.filteredStations.isEmpty) {
                  return const Center(child: Text('No stations found.'));
                }

    List<String> tabs = ['Pos Duga Air', 'Pos Curah Hujan', 'Pos Klimatlogi'];
                return Padding(
                  padding: EdgeInsets.all(12.w),

child: Column(
  children: [
    // Tambah bagian navigasi tab di sini
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(tabs.length, (index) {
        final isSelected = controller.selectedIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => controller.changeTab(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }),
    ),
    
    const SizedBox(height: 2),

    // Scrollable List
    Expanded(
      child: ListView.builder(
        itemCount: controller.filteredStations.length,
        itemBuilder: (context, index) {
          final station = controller.filteredStations[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.h),
            title: Text(station.name, style: const TextStyle(color: Colors.black87)),
            subtitle: Text(station.stationType, style: const TextStyle(color: Colors.black54)),
          );
        },
      ),
    ),
  ],
),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

                      // Expanded(
                      //   child: ListView.separated(
                      //     itemCount: controller.filteredStations.length,
                      //     separatorBuilder: (_, __) => const SizedBox(height: 8),
                      //     itemBuilder: (context, index) {
                      //       final station = controller.filteredStations[index];
                      //       return ListTile(
                      //         contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.h),
                      //         title: Text(station.name, style: const TextStyle(color: Colors.black87)),
                      //         subtitle: Text(station.stationType, style: const TextStyle(color: Colors.black54)),
                      //         trailing: const Icon(Icons.chevron_right),
                      //         tileColor: Colors.grey.shade100,
                      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      //       );
                      //     },
                      //   ),
                      // ),