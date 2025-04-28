class StationModel {
  int id;
  String stationName;
  String deviceStatus;
  String stationType;
  String? latitude;
  String? longitude;
  String? balaiName;
  String? organizationCode;

  StationModel({
    this.id = 0,
    this.stationName = '',
    this.deviceStatus = '',
    this.stationType = '',
    this.latitude,
    this.longitude,
    this.balaiName,
    this.organizationCode,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    var deviceStatusValue = json['deviceStatus'];
    String deviceStatusString;

    if (deviceStatusValue == true) {
      deviceStatusString = 'online';
    } else if (deviceStatusValue == false) {
      deviceStatusString = 'offline';
    } else if (deviceStatusValue is String) {
      deviceStatusString = deviceStatusValue.toLowerCase();
    } else {
      deviceStatusString = 'unknown';
    }

    return StationModel(
      id: json['id'] ?? 0,
      stationName: json['stationName'] ?? '',
      deviceStatus: deviceStatusString,
      stationType: json['stationType'] ?? '',
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      balaiName: json['balaiName'],
      organizationCode: json['organizationCode'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stationName': stationName,
      'deviceStatus': deviceStatus,
      'stationType': stationType,
      'latitude': latitude,
      'longitude': longitude,
      'balaiName': balaiName,
      'organizationCode': organizationCode,
    };
  }
}
