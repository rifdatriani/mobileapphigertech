abstract class AppRoute {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/';
  static const stations = '/stations';
  static const stationDetail = '/station/detail/:station_id';

  // Fungsi bantu untuk generate route lengkap dengan parameter
  static String stationDetailWithId(String id) => '/station/detail/$id';
}
