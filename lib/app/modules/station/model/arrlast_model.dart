class ArrlastModel {
  final String? deviceId;
  final String? readingAt;
  final double? rainfall;
  final int? warningStatus;
  final bool? deviceStatus;

  ArrlastModel({
    this.deviceId,
    this.readingAt,
    this.rainfall,
    this.warningStatus,
    this.deviceStatus,
  });

  factory ArrlastModel.fromJson(Map<String, dynamic> json) {
    return ArrlastModel(
      deviceId: json['deviceId'],
      readingAt: json['readingAt'],
      rainfall: (json['rainfall'] as num?)?.toDouble(),
      warningStatus: json['warningStatus'],
      deviceStatus: json['deviceStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'readingAt': readingAt,
      'rainfall': rainfall,
      'warningStatus': warningStatus,
      'deviceStatus': deviceStatus,
    };
  }
}
