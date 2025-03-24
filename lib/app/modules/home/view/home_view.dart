import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
// import 'package:mobileapphigertech/app/modules/home/view/widget/station_grid_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobileapphigertech/app/modules/home/view/widget/station_grid_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: Column(
        children: [
          // Map Section (Lingkaran Biru)
          SizedBox(
            height: 200,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-6.914744, 107.609810),
                zoom: 5,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
          
          Expanded(
            child: GetBuilder<HomeController>(
              builder: (ctrl) {
                if (ctrl.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (ctrl.status.isError) {
                  return Center(child: Text('Error: ${ctrl.status.errorMessage}'));
                }

                if (ctrl.status.isEmpty) {
                  return const Center(child: Text('No stations found'));
                }

                return Column(
                  children: [
                    // Station Overview (Lingkaran Merah)
                    SizedBox(height: 150, child: StationOverviewGrid(data: ctrl.countStation)),
                    
                    // Informasi Instansi (Lingkaran Hitam)
                    Expanded(
                      child: ListView.builder(
                        itemCount: ctrl.stations.length,
                        itemBuilder: (context, index) {
                          final station = ctrl.stations[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(station.organizationCode ?? 'Unknown'),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.wifi, size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text('$ctrl.countStation.online ?? 0}'),
                                  SizedBox(width: 8),
                                  Icon(Icons.offline_bolt, size: 16, color: Colors.red),
                                  SizedBox(width: 4),
                                  Text('${ctrl.countStation.offline ?? 0}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
