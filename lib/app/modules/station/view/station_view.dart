import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/station/controller/station_controller.dart';

class StationView extends GetView<StationController> {
  const StationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil argument dengan aman
    final String balai = Get.arguments?.toString() ?? 'Station';

    return Scaffold(
      appBar: AppBar(
        title: Text(balai),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<StationController>(
        builder: (controller) {
          if (controller.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.status.isError) {
            return Center(child: Text('Error: ${controller.status.errorMessage}'));
          }

          if (controller.filteredStations.isEmpty) {
            return const Center(child: Text('No stations found.'));
          }

          return Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'search ...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  onChanged: controller.searchStations,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.filteredStations.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final station = controller.filteredStations[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.h),
                        title: Text(station.name, style: const TextStyle(color: Colors.black87)),
                        subtitle: Text(station.stationType, style: const TextStyle(color: Colors.black54)),
                        trailing: const Icon(Icons.chevron_right),
                        tileColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onTap: () {
                          print('Tapped ${station.name}');
                          // Arahkan ke detail kalau perlu
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
