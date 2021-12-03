// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.inactive,
    required this.leagues,
    required this.teams,
    required this.members,
    required this.devices,
    required this.scheduledGames,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool inactive;
  List<League>? leagues;
  List<Eam>? teams;
  List<dynamic>? members;
  List<Device>? devices;
  List<ScheduledGame>? scheduledGames;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        inactive: json["inactive"] == null ? null : json["inactive"],
        leagues: json["leagues"] == null
            ? null
            : List<League>.from(json["leagues"].map((x) => League.fromJson(x))),
        teams: json["teams"] == null
            ? null
            : List<Eam>.from(json["teams"].map((x) => Eam.fromJson(x))),
        members: json["members"] == null
            ? null
            : List<dynamic>.from(json["members"].map((x) => x)),
        devices: json["devices"] == null
            ? null
            : List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
        scheduledGames: json["scheduledGames"] == null
            ? null
            : List<ScheduledGame>.from(
                json["scheduledGames"].map((x) => ScheduledGame.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "inactive": inactive == null ? null : inactive,
        "leagues": leagues == null
            ? null
            : List<dynamic>.from(leagues!.map((x) => x.toJson())),
        "teams": teams == null
            ? null
            : List<dynamic>.from(teams!.map((x) => x.toJson())),
        "members":
            members == null ? null : List<dynamic>.from(members!.map((x) => x)),
        "devices": devices == null
            ? null
            : List<dynamic>.from(devices!.map((x) => x.toJson())),
        "scheduledGames": scheduledGames == null
            ? null
            : List<dynamic>.from(scheduledGames!.map((x) => x.toJson())),
      };
}

class Device {
  Device({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.deviceId,
    required this.name,
    required this.stream,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String deviceId;
  String name;
  Eam? stream;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        deviceId: json["deviceId"] == null ? null : json["deviceId"],
        name: json["name"] == null ? null : json["name"],
        stream: json["stream"] == null ? null : Eam.fromJson(json["stream"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
        "deviceId": deviceId == null ? null : deviceId,
        "name": name == null ? null : name,
        "stream": stream == null ? null : stream!.toJson(),
      };
}

class Eam {
  Eam({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.streamName,
    required this.name,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String streamName;
  String name;

  factory Eam.fromJson(Map<String, dynamic> json) => Eam(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        streamName: json["streamName"] == null ? null : json["streamName"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
        "streamName": streamName == null ? null : streamName,
        "name": name == null ? null : name,
      };
}

class League {
  League({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String name;

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "name": name == null ? null : name,
      };
}

class ScheduledGame {
  ScheduledGame({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.teamGameAssn,
    required this.deviceGameAssn,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int startTime;
  int endTime;
  Description? description;
  List<dynamic>? teamGameAssn;
  List<DeviceGameAssn>? deviceGameAssn;

  factory ScheduledGame.fromJson(Map<String, dynamic> json) => ScheduledGame(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        description: json["description"] == null
            ? null
            : descriptionValues.map[json["description"]],
        teamGameAssn: json["teamGameAssn"] == null
            ? null
            : List<dynamic>.from(json["teamGameAssn"].map((x) => x)),
        deviceGameAssn: json["deviceGameAssn"] == null
            ? null
            : List<DeviceGameAssn>.from(
                json["deviceGameAssn"].map((x) => DeviceGameAssn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "description":
            description == null ? null : descriptionValues.reverse[description],
        "teamGameAssn": teamGameAssn == null
            ? null
            : List<dynamic>.from(teamGameAssn!.map((x) => x)),
        "deviceGameAssn": deviceGameAssn == null
            ? null
            : List<dynamic>.from(deviceGameAssn!.map((x) => x.toJson())),
      };
}

enum Description { DESCRIPTION, EMPTY }

final descriptionValues =
    EnumValues({"description": Description.DESCRIPTION, "": Description.EMPTY});

class DeviceGameAssn {
  DeviceGameAssn({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.videoId,
    required this.isActive,
    required this.startTime,
    required this.endTime,
    required this.annotations,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String videoId;
  bool isActive;
  int startTime;
  int endTime;
  List<dynamic>? annotations;

  factory DeviceGameAssn.fromJson(Map<String, dynamic> json) => DeviceGameAssn(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        videoId: json["videoId"] == null ? null : json["videoId"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        annotations: json["annotations"] == null
            ? null
            : List<dynamic>.from(json["annotations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
        "videoId": videoId == null ? null : videoId,
        "isActive": isActive == null ? null : isActive,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "annotations": annotations == null
            ? null
            : List<dynamic>.from(annotations!.map((x) => x)),
      };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
