class MapMarkerModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String status;
  final String type; 
  final String? deviceId;
  final String? note;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? timeZone;
  final String? slug;
  final String? brandName;
  final double? lastReadingData;

  MapMarkerModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.type, 
    this.deviceId,
    this.note,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.timeZone,
    this.slug,
    this.brandName,
    this.lastReadingData,
  });

  factory MapMarkerModel.fromJson(Map<String, dynamic> json) {
    return MapMarkerModel(
      id: json['id']?.toString() ?? '-',
      name: json['name'] ?? 'Unknown',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'offline',
      type: json['type'] ?? 'Unknown',
      deviceId: json['deviceId'],
      note: json['note'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      createdBy: json['createdBy'],
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      updatedBy: json['updatedBy'],
      timeZone: json['timeZone'],
      slug: json['slug'],
      brandName: json['brandName'],
      lastReadingData: (json['lastReadingData'] as num?)?.toDouble(),
    );
  }
}
