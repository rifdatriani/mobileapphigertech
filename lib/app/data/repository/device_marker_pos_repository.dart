import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapphigertech/app/config/app_config.dart';
import 'package:mobileapphigertech/app/data/model/marker_pos_model.dart';

class DeviceMarkerRepository {
  final String _baseUrl = AppConfig.baseUrl;

  Future<List<MapMarkerModel>> fetchDeviceMarkers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/marker-pos'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => MapMarkerModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load markers: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching markers: $e');
      rethrow;
    }
  }
}
