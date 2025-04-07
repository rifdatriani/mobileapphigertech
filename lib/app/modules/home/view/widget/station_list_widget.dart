import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
import 'package:mobileapphigertech/app/routes/app_route.dart';

class StationListWidget extends StatefulWidget {
  const StationListWidget({super.key});

  @override
  _StationListWidgetState createState() => _StationListWidgetState();
}

class _StationListWidgetState extends State<StationListWidget> {
  int currentPage = 0;
  int itemsPerPage = 10;
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

        // Memfilter dan mengelompokkan stasiun menggunakan compute untuk proses di background
        final filteredStations = ctrl.stations.where((station) =>
            station.balaiName?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false).toList();
        
        // Mengelompokkan stasiun berdasarkan nama Balai
        final groupedStations = groupBy(
          filteredStations,
          (station) => station.balaiName ?? 'Unknown',
        );

        // Mengubah hasil pencarian menjadi daftar
        final stationEntries = groupedStations.entries.toList();
        final totalPages = (stationEntries.length / itemsPerPage).ceil();

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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Search Bar dengan debounce
                  TextField(
                    controller: _searchController,
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
                    onChanged: _debounceSearch,
                  ),
                  const SizedBox(height: 12),

                  // List Informasi Balai dengan ListView.builder untuk performa lebih baik
                  Expanded(
                    child: totalPages > 0 ? 
                    PageView.builder(
                      controller: _pageController,
                      itemCount: totalPages,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, pageIndex) {
                        final startIndex = pageIndex * itemsPerPage;
                        final endIndex = (startIndex + itemsPerPage < stationEntries.length) 
                            ? startIndex + itemsPerPage 
                            : stationEntries.length;
                        
                        final paginatedEntries = stationEntries.sublist(startIndex, endIndex);

                        return ListView.builder(
                          // Gunakan ListView.builder untuk performa yang lebih baik
                          itemCount: paginatedEntries.length,
                          itemBuilder: (context, index) {
                            final entry = paginatedEntries[index];
                            final balaiName = entry.key;
                            final stations = entry.value;

                            return BalaiItemCard(
                              balaiName: balaiName, 
                              stations: stations,
                              onlineCount: ctrl.countStation.online ?? 0,
                              offlineCount: ctrl.countStation.offline ?? 0
                            );
                          },
                        );
                      },
                    ) :
                    const Center(child: Text('Tidak ada hasil yang ditemukan')),
                  ),
                  
                  // Indikator halaman
                  if (totalPages > 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          totalPages > 5 ? 5 : totalPages,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
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

  // Fungsi debounce untuk pencarian
  void _debounceSearch(String query) {
    // Menggunakan Future.delayed untuk membuat debounce
    Future.delayed(const Duration(milliseconds: 300), () {
      if (query == _searchController.text) {
        setState(() {
          searchQuery = query;
          currentPage = 0;
          _pageController.jumpToPage(0);
        });
      }
    });
  }
}

// Widget terpisah untuk card stasiun untuk memisahkan rebuild
class BalaiItemCard extends StatelessWidget {
  final String balaiName;
  final List stations;
  final int onlineCount;
  final int offlineCount;

  const BalaiItemCard({
    super.key, 
    required this.balaiName, 
    required this.stations,
    required this.onlineCount,
    required this.offlineCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoute.stations, arguments: balaiName);
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
                _buildInfoItem(Icons.wifi, onlineCount),
                _buildInfoItem(Icons.wifi_off, offlineCount),
                _buildInfoItem(Icons.devices, stations.length),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan ikon + jumlah data
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