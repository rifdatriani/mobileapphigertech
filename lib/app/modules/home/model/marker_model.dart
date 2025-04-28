class MarkerModel {
  final double latitude;
  final double longitude;
  final String type;
  final String? deviceStatus;

  MarkerModel({
    required this.latitude,
    required this.longitude,
    required this.type,
    this.deviceStatus,
  });
}
