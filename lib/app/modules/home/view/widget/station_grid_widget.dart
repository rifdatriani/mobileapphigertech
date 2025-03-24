import 'package:flutter/material.dart';
import 'package:mobileapphigertech/app/modules/home/model/count_station_model.dart';

class StationOverviewGrid extends StatelessWidget {
  final CountStationModel data;

  const StationOverviewGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {"title": "Total Pos", "value": data.totalStation, "color": Colors.blue},
      {"title": "Online", "value": data.online, "color": Colors.green},
      {"title": "Offline", "value": data.offline, "color": Colors.red},
      {"title": "Instansi", "value": data.totalOrganization, "color": Colors.orange},
      {"title": "Duga Air", "value": data.totalAwlr, "color": Colors.teal},
      {"title": "Curah Hujan", "value": data.totalArr, "color": Colors.purple},
      {"title": "Klimatologi", "value": data.totalAws, "color": Colors.brown},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: List.generate(items.length, (index) {
          // Atur ukuran item agar baris pertama punya 4 item, baris kedua punya 3 item
          double width = (index < 4) 
              ? (MediaQuery.of(context).size.width - 64) / 4 // 4 kotak di atas
              : (MediaQuery.of(context).size.width - 48) / 3; // 3 kotak di bawah

          return Container(
            width: width,
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: items[index]["color"],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  items[index]["title"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${items[index]["value"]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
