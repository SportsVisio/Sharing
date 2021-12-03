// To parse this JSON data, do
//
//     final allTeamsModel = allTeamsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllTeamsModel> allTeamsModelFromJson(String str) =>
    List<AllTeamsModel>.from(
        json.decode(str).map((x) => AllTeamsModel.fromJson(x)));

String allTeamsModelToJson(List<AllTeamsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllTeamsModel {
  AllTeamsModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.imageUrl,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  String imageUrl;

  factory AllTeamsModel.fromJson(Map<String, dynamic> json) => AllTeamsModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        name: json["name"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "name": name,
        "imageUrl": imageUrl,
      };
}
