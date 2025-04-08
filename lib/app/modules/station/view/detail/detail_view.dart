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
    final double? waterLevel = double.tryParse(station.waterLevel?.toString() ?? '');
    final double? siaga1 = double.tryParse(station.siaga1?.toString() ?? '');
    final double? siaga2 = double.tryParse(station.siaga2?.toString() ?? '');
    final double? siaga3 = double.tryParse(station.siaga3?.toString() ?? '');

    // String status = 'TIDAK ADA DATA';
    // if (waterLevel != null && siaga1 != null && siaga2 != null && siaga3 != null) {
    //   if (waterLevel >= siaga1) {
    //     status = 'AWAS';
    //   } else if (waterLevel >= siaga2) {
    //     status = 'WASPADA';
    //   } else if (waterLevel >= siaga3) {
    //     status = 'NORMAL';
    //   }
    // }

return Card(
  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15), // tambah margin horizontal biar gak mepet
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  elevation: 3,
  child: Padding(
    padding: const EdgeInsets.all(16), // kasih padding biar card makin besar
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          station.name ?? '-',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18, // perbesar font title
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${station.deviceId ?? '-'} • ${station.unitDisplay} • ${station.unitSensor ?? 'device'}',
          style: const TextStyle(fontSize: 16, color: Colors.black), // font subtitle lebih gede
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              // color: getStatusColor(status),
              borderRadius: BorderRadius.circular(20),
            ),
            // child: Text(
            //   status,
            //   style: const TextStyle(
            //     color: Color.fromARGB(255, 1, 1, 1),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 14, // lebih besar dikit dari sebelumnya
            //   ),
            // ),
          ),
        ),
      ],
    ),
  ),
);

  }
}
