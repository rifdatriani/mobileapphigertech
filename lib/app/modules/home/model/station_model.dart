class StationModel {
  int id;
  String stationName;
  String deviceStatus;
  String stationType;

  StationModel({
    this.id = 0,
    this.stationName = '',
    this.deviceStatus = '',
    this.stationType = '',
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'] ?? 0,
      stationName: json['stationName'] ?? '',
      deviceStatus: json['deviceStatus'] ?? '',
      stationType: json['stationType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stationName': stationName,
      'deviceStatus': deviceStatus,
      'stationType': stationType,
    };
  }
}
