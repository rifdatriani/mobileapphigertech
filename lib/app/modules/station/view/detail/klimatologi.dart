import 'package:flutter/material.dart';
import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';

class KlimatologiCard extends StatelessWidget {
  final StationModel station;

  const KlimatologiCard({super.key, required this.station});

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
    final double? waterLevel = double.tryParse(
      station.waterLevel?.toString() ?? '',
    );
    final double? siaga1 = double.tryParse(station.siaga1?.toString() ?? '');
    final double? siaga2 = double.tryParse(station.siaga2?.toString() ?? '');
    final double? siaga3 = double.tryParse(station.siaga3?.toString() ?? '');

    String status = 'TIDAK ADA DATA';
    if (waterLevel != null &&
        siaga1 != null &&
        siaga2 != null &&
        siaga3 != null) {
      if (waterLevel >= siaga1) {
        status = 'AWAS';
      } else if (waterLevel >= siaga2) {
        status = 'WASPADA';
      } else if (waterLevel >= siaga3) {
        status = 'NORMAL';
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        title: Text(
          station.name ?? '-',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Tinggi Muka Air: ${station.siaga1.toString()} ${station.unitDisplay ?? ''}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: getStatusColor(status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


