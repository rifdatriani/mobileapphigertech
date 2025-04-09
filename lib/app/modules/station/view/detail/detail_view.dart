import 'package:flutter/material.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';

class StationCard extends StatelessWidget {
  final StationModel station;

  const StationCard({super.key, required this.station});

  Color getStatusColor(String status) {
    switch (status) {
      case 'AWAS':
        return Colors.red;
      case 'WASPADA':
        return Colors.orange;
      case 'NORMAL':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama Stasiun: $name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Tipe Stasiun: $type",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}