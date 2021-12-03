// To parse this JSON data, do
//
//     final registerDeviceModel = registerDeviceModelFromJson(jsonString);

import 'dart:convert';

RegisterDeviceModel registerDeviceModelFromJson(String str) =>
    RegisterDeviceModel.fromJson(json.decode(str));

String registerDeviceModelToJson(RegisterDeviceModel data) =>
    json.encode(data.toJson());

class RegisterDeviceModel {
  RegisterDeviceModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.name,
    required this.account,
    required this.stream,
    required this.gameAssn,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String deviceId;
  String name;
  Account? account;
  Stream? stream;
  GameAssn? gameAssn;

  factory RegisterDeviceModel.fromJson(Map<String, dynamic> json) =>
      RegisterDeviceModel(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deviceId: json["deviceId"] == null ? null : json["deviceId"],
        name: json["name"] == null ? null : json["name"],
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        stream: json["stream"] == null ? null : Stream.fromJson(json["stream"]),
        gameAssn: json["gameAssn"] == null
            ? null
            : GameAssn.fromJson(json["gameAssn"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deviceId": deviceId == null ? null : deviceId,
        "name": name == null ? null : name,
        "account": account == null ? null : account!.toJson(),
        "stream": stream == null ? null : stream!.toJson(),
        "gameAssn": gameAssn == null ? null : gameAssn!.toJson(),
      };
}

class Account {
  Account({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.inactive,
    required this.owner,
    required this.teams,
    required this.leagues,
    required this.members,
    required this.devices,
    required this.scheduledGames,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool inactive;
  Owner? owner;
  List<League>? teams;
  List<League>? leagues;
  List<Member>? members;
  List<String>? devices;
  List<Game>? scheduledGames;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        inactive: json["inactive"] == null ? null : json["inactive"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        teams: json["teams"] == null
            ? null
            : List<League>.from(json["teams"].map((x) => League.fromJson(x))),
        leagues: json["leagues"] == null
            ? null
            : List<League>.from(json["leagues"].map((x) => League.fromJson(x))),
        members: json["members"] == null
            ? null
            : List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        devices: json["devices"] == null
            ? null
            : List<String>.from(json["devices"].map((x) => x)),
        scheduledGames: json["scheduledGames"] == null
            ? null
            : List<Game>.from(
                json["scheduledGames"].map((x) => Game.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "inactive": inactive == null ? null : inactive,
        "owner": owner == null ? null : owner!.toJson(),
        "teams": teams == null
            ? null
            : List<dynamic>.from(teams!.map((x) => x.toJson())),
        "leagues": leagues == null
            ? null
            : List<dynamic>.from(leagues!.map((x) => x.toJson())),
        "members": members == null
            ? null
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "devices":
            devices == null ? null : List<dynamic>.from(devices!.map((x) => x)),
        "scheduledGames": scheduledGames == null
            ? null
            : List<dynamic>.from(scheduledGames!.map((x) => x.toJson())),
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

class Member {
  Member({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.accepted,
    required this.user,
    required this.account,
    required this.roles,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool accepted;
  String user;
  String account;
  List<Role>? roles;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        accepted: json["accepted"] == null ? null : json["accepted"],
        user: json["user"] == null ? null : json["user"],
        account: json["account"] == null ? null : json["account"],
        roles: json["roles"] == null
            ? null
            : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "accepted": accepted == null ? null : accepted,
        "user": user == null ? null : user,
        "account": account == null ? null : account,
        "roles": roles == null
            ? null
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  Role({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.accountMemberAssn,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String role;
  String accountMemberAssn;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        role: json["role"] == null ? null : json["role"],
        accountMemberAssn: json["accountMemberAssn"] == null
            ? null
            : json["accountMemberAssn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "role": role == null ? null : role,
        "accountMemberAssn":
            accountMemberAssn == null ? null : accountMemberAssn,
      };
}

class Owner {
  Owner({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.inactive,
    required this.account,
    required this.accountRoleAssn,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String firstName;
  String lastName;
  String email;
  bool inactive;
  String account;
  List<Member>? accountRoleAssn;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
        inactive: json["inactive"] == null ? null : json["inactive"],
        account: json["account"] == null ? null : json["account"],
        accountRoleAssn: json["accountRoleAssn"] == null
            ? null
            : List<Member>.from(
                json["accountRoleAssn"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "inactive": inactive == null ? null : inactive,
        "account": account == null ? null : account,
        "accountRoleAssn": accountRoleAssn == null
            ? null
            : List<dynamic>.from(accountRoleAssn!.map((x) => x.toJson())),
      };
}

class Game {
  Game({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.league,
    required this.court,
    required this.teamGameAssn,
    required this.deviceGameAssn,
    required this.account,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int startTime;
  int endTime;
  String description;
  League? league;
  League? court;
  List<League>? teamGameAssn;
  List<String>? deviceGameAssn;
  String account;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        description: json["description"] == null ? null : json["description"],
        league: json["league"] == null ? null : League.fromJson(json["league"]),
        court: json["court"] == null ? null : League.fromJson(json["court"]),
        teamGameAssn: json["teamGameAssn"] == null
            ? null
            : List<League>.from(
                json["teamGameAssn"].map((x) => League.fromJson(x))),
        deviceGameAssn: json["deviceGameAssn"] == null
            ? null
            : List<String>.from(json["deviceGameAssn"].map((x) => x)),
        account: json["account"] == null ? null : json["account"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "description": description == null ? null : description,
        "league": league == null ? null : league!.toJson(),
        "court": court == null ? null : court!.toJson(),
        "teamGameAssn": teamGameAssn == null
            ? null
            : List<dynamic>.from(teamGameAssn!.map((x) => x.toJson())),
        "deviceGameAssn": deviceGameAssn == null
            ? null
            : List<dynamic>.from(deviceGameAssn!.map((x) => x)),
        "account": account == null ? null : account,
      };
}

class GameAssn {
  GameAssn({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.videoId,
    required this.isActive,
    required this.startTime,
    required this.endTime,
    required this.game,
    required this.device,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String videoId;
  bool isActive;
  int startTime;
  int endTime;
  Game? game;
  String device;

  factory GameAssn.fromJson(Map<String, dynamic> json) => GameAssn(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        videoId: json["videoId"] == null ? null : json["videoId"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        game: json["game"] == null ? null : Game.fromJson(json["game"]),
        device: json["device"] == null ? null : json["device"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "videoId": videoId == null ? null : videoId,
        "isActive": isActive == null ? null : isActive,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "game": game == null ? null : game!.toJson(),
        "device": device == null ? null : device,
      };
}

class Stream {
  Stream({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.streamName,
    required this.device,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String streamName;
  String device;

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        streamName: json["streamName"] == null ? null : json["streamName"],
        device: json["device"] == null ? null : json["device"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "streamName": streamName == null ? null : streamName,
        "device": device == null ? null : device,
      };
}
