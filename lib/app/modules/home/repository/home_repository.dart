import 'package:mobileapphigertech/app/modules/station/model/station_model.dart';
import 'package:mobileapphigertech/app/services/api_services.dart';

class HomeRepository {
  final ApiService _apiService = ApiService();

  Future<List<StationModel>> fetchStationList() async {
    final response = await _apiService.getRequest(
      'station/All',
    ); // pastikan endpoint-nya benar

    if (response.isSuccess && response.data is List) {
      print('Response station data: ${response.data}');
      return (response.data as List)
          .map((json) => StationModel.fromJson(json))
          .toList();
    } else {
      throw Exception(response.message);
    }
  }
}
