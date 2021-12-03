// To parse this JSON data, do
//
//     final statsModel = statsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StatsModel statsModelFromJson(String str) =>
    StatsModel.fromJson(json.decode(str));

String statsModelToJson(StatsModel data) => json.encode(data.toJson());

class StatsModel {
  StatsModel({
    required this.fieldGoals,
    required this.threePoints,
    required this.twoPoints,
    required this.freeThrows,
    required this.totalPoints,
    required this.offensiveRebounds,
    required this.defensiveRebounds,
    required this.totalRebounds,
    required this.assists,
  });

  FieldGoals fieldGoals;
  FieldGoals threePoints;
  FieldGoals twoPoints;
  FieldGoals freeThrows;
  int totalPoints;
  int offensiveRebounds;
  int defensiveRebounds;
  int totalRebounds;
  int assists;

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
        fieldGoals: FieldGoals.fromJson(json["fieldGoals"]),
        threePoints: FieldGoals.fromJson(json["threePoints"]),
        twoPoints: FieldGoals.fromJson(json["twoPoints"]),
        freeThrows: FieldGoals.fromJson(json["freeThrows"]),
        totalPoints: json["totalPoints"],
        offensiveRebounds: json["offensiveRebounds"],
        defensiveRebounds: json["defensiveRebounds"],
        totalRebounds: json["totalRebounds"],
        assists: json["assists"],
      );

  Map<String, dynamic> toJson() => {
        "fieldGoals": fieldGoals.toJson(),
        "threePoints": threePoints.toJson(),
        "twoPoints": twoPoints.toJson(),
        "freeThrows": freeThrows.toJson(),
        "totalPoints": totalPoints,
        "offensiveRebounds": offensiveRebounds,
        "defensiveRebounds": defensiveRebounds,
        "totalRebounds": totalRebounds,
        "assists": assists,
      };
}

class FieldGoals {
  FieldGoals({
    required this.made,
    required this.attempts,
  });

  int made;
  int attempts;

  factory FieldGoals.fromJson(Map<String, dynamic> json) => FieldGoals(
        made: json["made"],
        attempts: json["attempts"],
      );

  Map<String, dynamic> toJson() => {
        "made": made,
        "attempts": attempts,
      };
}
