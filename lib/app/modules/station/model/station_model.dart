class StationModel {
  final dynamic id;
  final dynamic slug;
  final dynamic organizationCode;
  final dynamic balaiName;
  final dynamic photo;
  final dynamic subDomain;
  final dynamic subDomainOld;
  final dynamic noRegister;
  final dynamic name;
  final dynamic stationType;
  final dynamic type;
  final dynamic elevation;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic riverAreaId;
  final dynamic watershedId;
  final dynamic provinceId;
  final dynamic regencyId;
  final dynamic districtId;
  final dynamic villageId;
  final dynamic builtYear;
  final dynamic builtBy;
  final dynamic renovationYear;
  final dynamic renovationBy;
  final dynamic note;
  final dynamic createdAt;
  final dynamic createdBy;
  final dynamic updatedAt;
  final dynamic updatedBy;
  final dynamic deletedAt;
  final dynamic deletedBy;
  final dynamic deviceId;
  final dynamic noGsm;
  final dynamic installedDate;
  final dynamic calibration;
  final dynamic brandCode;
  final dynamic brandName;
  final dynamic riverAreaName;
  final dynamic watershedName;
  final dynamic provinceName;
  final dynamic regencyName;
  final dynamic districtName;
  final dynamic villageName;
  final dynamic unitDisplay;
  final dynamic unitSensor;
  final dynamic peilschaalBasisValue;
  final dynamic peilschaalBasisElevation;
  final dynamic konstantaA;
  final dynamic konstantaB;
  final dynamic siaga1;
  final dynamic siaga2;
  final dynamic siaga3;
  final dynamic heightMercu;
  final dynamic lastReadingAt;
  final dynamic deviceStatus;
  final dynamic username;
  final dynamic password;
  final dynamic warningStatus;
  final dynamic waterLevel;
  final AwlrlastModel? awlrLastReading;
  final ArrlastModel? arrLastReading;
  final dynamic rainfall;
  final dynamic rainfallLastHour;
  final dynamic rainfallLastDay;
  final dynamic rainfallMax;
  final dynamic intensityLastHour;
  final dynamic intensityLastDay;

  StationModel({
    this.id,
    this.slug,
    this.organizationCode,
    this.balaiName,
    this.photo,
    this.subDomain,
    this.subDomainOld,
    this.noRegister,
    this.name,
    this.stationType,
    this.type,
    this.elevation,
    this.latitude,
    this.longitude,
    this.riverAreaId,
    this.watershedId,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.builtYear,
    this.builtBy,
    this.renovationYear,
    this.renovationBy,
    this.note,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
    this.deviceId,
    this.noGsm,
    this.installedDate,
    this.calibration,
    this.brandCode,
    this.brandName,
    this.riverAreaName,
    this.watershedName,
    this.provinceName,
    this.regencyName,
    this.districtName,
    this.villageName,
    this.unitDisplay,
    this.unitSensor,
    this.peilschaalBasisValue,
    this.peilschaalBasisElevation,
    this.konstantaA,
    this.konstantaB,
    this.siaga1,
    this.siaga2,
    this.siaga3,
    this.heightMercu,
    this.lastReadingAt,
    this.deviceStatus,
    this.username,
    this.password,
    this.warningStatus,
    this.waterLevel,
    this.awlrLastReading,
    this.rainfall,
    this.rainfallLastHour,
    this.rainfallLastDay,
    this.rainfallMax,
    this.intensityLastHour,
    this.intensityLastDay,
    this.arrLastReading,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
    id: json['id'],
    slug: json['slug'],
    organizationCode: json['organizationCode'],
    balaiName: json['balaiName'],
    photo: json['photo'],
    subDomain: json['subDomain'],
    subDomainOld: json['subDomainOld'],
    noRegister: json['noRegister'],
    name: json['name'],
    stationType: json['stationType'],
    type: json['type'],
    elevation: json['elevation'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    riverAreaId: json['riverAreaId'],
    watershedId: json['watershedId'],
    provinceId: json['provinceId'],
    regencyId: json['regencyId'],
    districtId: json['districtId'],
    villageId: json['villageId'],
    builtYear: json['builtYear'],
    builtBy: json['builtBy'],
    renovationYear: json['renovationYear'],
    renovationBy: json['renovationBy'],
    note: json['note'],
    createdAt: json['createdAt'],
    createdBy: json['createdBy'],
    updatedAt: json['updatedAt'],
    updatedBy: json['updatedBy'],
    deletedAt: json['deletedAt'],
    deletedBy: json['deletedBy'],
    deviceId: json['deviceId'],
    noGsm: json['noGsm'],
    installedDate: json['installedDate'],
    calibration: json['calibration'],
    brandCode: json['brandCode'],
    brandName: json['brandName'],
    riverAreaName: json['riverAreaName'],
    watershedName: json['watershedName'],
    provinceName: json['provinceName'],
    regencyName: json['regencyName'],
    districtName: json['districtName'],
    villageName: json['villageName'],
    unitDisplay: json['unitDisplay'],
    unitSensor: json['unitSensor'],
    peilschaalBasisValue: json['peilschaalBasisValue'],
    peilschaalBasisElevation: json['peilschaalBasisElevation'],
    konstantaA: json['konstantaA'],
    konstantaB: json['konstantaB'],
    siaga1: json['siaga1'],
    siaga2: json['siaga2'],
    siaga3: json['siaga3'],
    heightMercu: json['heightMercu'],
    lastReadingAt: json['lastReadingAt'],
    deviceStatus: json['deviceStatus'],
    username: json['username'],
    password: json['password'],
    warningStatus: json['warningStatus'],
    waterLevel: json['waterLevel'],
    awlrLastReading: json['awlrLastReading'] != null
      ? AwlrlastModel.fromJson(json['awlrLastReading'])
      : null,
  arrLastReading: json['arrLastReading'] != null
      ? ArrlastModel.fromJson(json['arrLastReading'])
      : null,
    rainfall: json['rainfall'],
    rainfallLastHour: json['rainfallLastHour'],
    rainfallLastDay: json['rainfallLastDay'],
    rainfallMax: json['rainfallMax'],
    intensityLastHour: json['intensityLastHour'],
    intensityLastDay: json['intensityLastDay'],
  );

  get status => null;
}

class AwlrlastModel {
  String? deviceId;
  String? waterLevel;
  String? warningStatus;

  AwlrlastModel({this.deviceId, this.waterLevel, this.warningStatus});

  AwlrlastModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    waterLevel = json['waterLevel'];
    warningStatus = json['warningStatus'];
  }
}

class ArrlastModel {
  String? deviceId;
  String? rainfall;
  String? intensity;
  String? deviceStatus;

  ArrlastModel({this.deviceId, this.rainfall, this.intensity, this.deviceStatus});

  ArrlastModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    rainfall = json['rainfall'];
    intensity = json['intensity'];
    deviceStatus = json['deviceStatus'];
  }
}
