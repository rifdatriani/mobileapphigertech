import 'awlrlast_model.dart';
import 'arrlast_model.dart';

class StationModel {

  final dynamic organizationCode;
  final dynamic balaiName;
  final dynamic name;
  final dynamic stationType;
  final dynamic type;
  final dynamic latitude;
  final dynamic longitude;
  final dynamic deviceId;
  final dynamic unitDisplay;
  final dynamic unitSensor;
  final dynamic siaga1;
  final dynamic siaga2;
  final dynamic siaga3;
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
    this.organizationCode,
    this.balaiName,
    this.name,
    this.stationType,
    this.type,
    this.latitude,
    this.longitude,
    this.deviceId,
    this.unitDisplay,
    this.unitSensor,
    this.siaga1,
    this.siaga2,
    this.siaga3,
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
    organizationCode: json['organizationCode'],
    balaiName: json['balaiName'],
    name: json['name'],
    stationType: json['stationType'],
    type: json['type'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    deviceId: json['deviceId'],
    unitDisplay: json['unitDisplay'],
    unitSensor: json['unitSensor'],
    siaga1: json['siaga1'],
    siaga2: json['siaga2'],
    siaga3: json['siaga3'],
    lastReadingAt: json['lastReadingAt'],
    deviceStatus: json['deviceStatus'],
    username: json['username'],
    password: json['password'],
    warningStatus: json['warningStatus'],
    waterLevel: json['waterLevel'],
    awlrLastReading:
        json['awlrLastReading'] != null
            ? AwlrlastModel.fromJson(json['awlrLastReading'])
            : null,
    arrLastReading:
        json['arrLastReading'] != null
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