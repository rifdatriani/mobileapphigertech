import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapphigertech/app/modules/home/controller/home_controller.dart';
import 'package:mobileapphigertech/app/modules/home/model/count_station_model.dart';

class StationOverviewGrid extends StatelessWidget {
  const StationOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return GetBuilder<HomeController>(builder: (ctrl) {
      if (ctrl.status.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (ctrl.status.isError) {
        return Center(child: Text('Error: ${ctrl.status.errorMessage}'));
      }

      if (ctrl.status.isEmpty) {
        return const Center(child: Text('No stations found'));
      }

      CountStationModel data = ctrl.countStation;
      List<Map<String, dynamic>> items = [
        {
          "title": "Total Pos",
          "value": data.totalStation,
          "color": Colors.blue,
        },
        {
          "title": "Online",
          "value": data.online,
          "color": Colors.green,
        },
        {
          "title": "Offline",
          "value": data.offline,
          "color": Colors.red,
        },
        {
          "title": "Instansi",
          "value": data.totalOrganization,
          "color": Colors.orange,
        },
        {
          "title": "Duga Air",
          "value": data.totalAwlr,
          "color": Colors.teal,
        },
        {
          "title": "Curah Hujan",
          "value": data.totalArr,
          "color": Colors.purple,
        },
        {
          "title": "Klimatologi",
          "value": data.totalAws,
          "color": Colors.brown,
        },
      ];

      print('DATA STATION:');
      print('Total Pos: ${data.totalStation}');
      print('Online: ${data.online}');
      print('Offline: ${data.offline}');
      print('Instansi: ${data.totalOrganization}');
      print('Duga Air: ${data.totalAwlr}');
      print('Curah Hujan: ${data.totalArr}');
      print('Klimatologi: ${data.totalAws}');

      int crossAxisCount = isTablet ? 4 : 3;

      int topRowCount = isTablet ? 3 : 4;

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.all(size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  topRowCount,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.005),
                      child: _buildGridItem(items[index], context),
                    ),
                  ),
                ),
              ),
            ),

            if (items.length > topRowCount)
              Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: size.width * 0.01,
                  crossAxisSpacing: size.width * 0.01,
                  children: List.generate(
                    items.length - topRowCount,
                    (index) =>
                        _buildGridItem(items[index + topRowCount], context),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildGridItem(Map<String, dynamic> item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: item["color"],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${item["value"]}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
