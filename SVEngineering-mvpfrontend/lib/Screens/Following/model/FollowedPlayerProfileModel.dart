// To parse this JSON data, do
//
//     final followedPlayerProfileModel = followedPlayerProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FollowedPlayerProfileModel> followedPlayerProfileModelFromJson(
        String str) =>
    List<FollowedPlayerProfileModel>.from(
        json.decode(str).map((x) => FollowedPlayerProfileModel.fromJson(x)));

String followedPlayerProfileModelToJson(
        List<FollowedPlayerProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FollowedPlayerProfileModel {
  FollowedPlayerProfileModel({
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
  List<TeamPlayerAssn> teamPlayerAssn;

  factory FollowedPlayerProfileModel.fromJson(Map<String, dynamic> json) =>
      FollowedPlayerProfileModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        imageUrl: json["imageUrl"],
        nickName: json["nickName"],
        teamPlayerAssn: List<TeamPlayerAssn>.from(
            json["teamPlayerAssn"].map((x) => TeamPlayerAssn.fromJson(x))),
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
        "teamPlayerAssn":
            List<dynamic>.from(teamPlayerAssn.map((x) => x.toJson())),
      };
}

class TeamPlayerAssn {
  TeamPlayerAssn({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.approved,
    required this.player,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  bool approved;
  Player player;

  factory TeamPlayerAssn.fromJson(Map<String, dynamic> json) => TeamPlayerAssn(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        approved: json["approved"],
        player: Player.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "approved": approved,
        "player": player.toJson(),
      };
}

class Player {
  Player({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.number,
    required this.team,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  String number;
  Team team;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        name: json["name"],
        number: json["number"],
        team: Team.fromJson(json["team"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "name": name,
        "number": number,
        "team": team.toJson(),
      };
}

class Team {
  Team({
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

  factory Team.fromJson(Map<String, dynamic> json) => Team(
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
