class AwlrlastModel {
  final String? deviceId;
  final String? readingAt;
  final double? waterLevel;
  final int? warningStatus;
  final String? deviceStatus;

  AwlrlastModel({
    this.deviceId,
    this.readingAt,
    this.waterLevel,
    this.warningStatus,
    this.deviceStatus,
  });

  factory AwlrlastModel.fromJson(Map<String, dynamic> json) {
    return AwlrlastModel(
      deviceId: json['deviceId'],
      readingAt: json['readingAt'],
      waterLevel: (json['waterLevel'] as num?)?.toDouble(),
      warningStatus: json['warningStatus'],
      deviceStatus: json['deviceStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'readingAt': readingAt,
      'waterLevel': waterLevel,
      'warningStatus': warningStatus,
      'deviceStatus': deviceStatus,
    };
  }
}
