import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/controller/logout_controller.dart';
import 'package:mobileapphigertech/app/modules/screens/logout/view/logout_view.dart';
import 'package:mobileapphigertech/app/modules/station/controller/station_controller.dart';
import 'package:mobileapphigertech/app/modules/station/view/detail/curah_hujan.dart';
import 'package:mobileapphigertech/app/modules/station/view/detail/duga_air.dart';
import 'package:mobileapphigertech/app/modules/station/view/detail/duga_and_curah.dart';
import 'package:mobileapphigertech/app/modules/station/view/detail/klimatologi.dart';
import 'package:mobileapphigertech/app/modules/station/view/map/map_station.dart';

class StationView extends GetView<StationController> {
  const StationView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    final String balai = args?['balaiName'] ?? 'Station';
    final double latitude = args?['lat'] ?? -2.5489;
    final double longitude = args?['lng'] ?? 118.0149;

    final List<dynamic> tabs = controller.stationTypes;

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
                Get.put(LogoutController());
              }
              Get.dialog(const LogoutView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: StationMap(latitude: latitude, longitude: longitude),
              ),
            ),
          ),
          const SizedBox(height: 1),
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

                return Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          controller.stationTypes.length,
                          (index) {
                            final isSelected =
                                controller.selectedIndex == index;
                            final tabName =
                                stationTypeLabels[controller
                                    .stationTypes[index]] ??
                                controller.stationTypes[index];
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => controller.changeTab(index),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected ? Colors.blue : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    tabName,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 2),

                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredStations.length,
                          itemBuilder: (context, index) {
                            final station = controller.filteredStations[index];
                            
                            switch (station.stationType) {
                              case 'AWLR':
                                return CurahHujanCard(station: station);
                              case 'PCH':
                                return CurahHujanCard(station: station);
                              case 'PDA':
                                return DugaAirCard(station: station);
                              case 'ARR':
                                return DugaAirCard(station: station);
                              case 'AWS':
                                return KlimatologiCard(station: station);
                              case 'AWLR_ARR':
                                return DugaCurahCard(station: station);
                              default:
                                return const SizedBox();
                            }
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
