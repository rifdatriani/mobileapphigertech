abstract class AppRoute {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/';
  static const stations = '/stations';
  static const stationDetail = '/station/detail/:station_id';
  static const String logout = '/logout';
  static const String navbar = '/navbar';

  // Fungsi bantu untuk generate route lengkap dengan parameter
  static String stationDetailWithId(String id) => '/station/detail/$id';
}
