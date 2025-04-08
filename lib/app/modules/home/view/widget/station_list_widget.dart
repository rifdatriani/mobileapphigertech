import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

class StationListWidget extends StatefulWidget {
  final bool showSearch;

  const StationListWidget({super.key, this.showSearch = true});

  @override
  _StationListWidgetState createState() => _StationListWidgetState();
}

class _StationListWidgetState extends State<StationListWidget> {
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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

        // Mengelompokkan stasiun berdasarkan nama Balai
        final groupedStations = groupBy(
          filteredStations,
          (station) => station.balaiName ?? 'Unknown',
        );

        final stationEntries = groupedStations.entries.toList();
        final totalPages = (stationEntries.length / itemsPerPage).ceil();

        // Menampilkan 10 balai tetap
        final displayedEntries = stationEntries.take(10).toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Center(
                    child: Text(
                      'Informasi Instansi',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Search Bar
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Cari Balai...",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                    ),
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                        currentPage = 0;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // List Informasi Balai
                  // List Informasi Balai
                  Expanded(
                    child: PageView.builder(
                      itemCount: totalPages,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, pageIndex) {
                        final paginatedEntries = stationEntries
                            .skip(pageIndex * itemsPerPage)
                            .take(itemsPerPage)
                            .toList();

                        return Column(
                          children: paginatedEntries.map((entry) {
                            final balaiName = entry.key;
                            final stations = entry.value;

                            return InkWell(
                              onTap: () {
                               // Ambil lokasi pertama dari daftar stasiun pada balai yang dipilih
                                final firstStation = stations.first;
                                Get.toNamed(AppRoute.stations, arguments: {
                                  'lat': firstStation.latitude,
                                  'lng': firstStation.longitude,  
                                  'balaiName': balaiName,
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.blueAccent, width: 2),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Nama Balai
                                    Text(
                                      balaiName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),

                                    // Statistik Online, Offline, dan Total Stasiun
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildInfoItem(Icons.wifi, ctrl.countStation.online ?? 0),
                                        _buildInfoItem(Icons.wifi_off, ctrl.countStation.offline ?? 0),
                                        _buildInfoItem(Icons.devices, stations.length),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(IconData icon, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.black87),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}