// To parse this JSON data, do
//
//     final playerProfileModel = playerProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlayerProfileModel playerProfileModelFromJson(String str) =>
    PlayerProfileModel.fromJson(json.decode(str));

String playerProfileModelToJson(PlayerProfileModel data) =>
    json.encode(data.toJson());

class PlayerProfileModel {
  PlayerProfileModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.nickName,
    required this.teamPlayerAssn,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String firstName;
  String lastName;
  String imageUrl;
  String nickName;
  List<dynamic> teamPlayerAssn;

  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) =>
      PlayerProfileModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        imageUrl: json["imageUrl"],
        nickName: json["nickName"],
        teamPlayerAssn:
            List<dynamic>.from(json["teamPlayerAssn"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "firstName": firstName,
        "lastName": lastName,
        "imageUrl": imageUrl,
        "nickName": nickName,
        "teamPlayerAssn": List<dynamic>.from(teamPlayerAssn.map((x) => x)),
      };
}
