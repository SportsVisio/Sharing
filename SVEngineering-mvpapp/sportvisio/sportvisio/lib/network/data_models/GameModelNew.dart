import 'package:intl/intl.dart';
import 'package:sportvisio/network/api_response.dart';

class GameModel {
  GameModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.season,
    this.processedVideoUrl,
    required this.league,
    required this.court,
    required this.teamGameAssn,
    required this.deviceGameAssn,
  });

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int startTime;
  int endTime;
  String description;
  String season;
  String? processedVideoUrl;
  League league;
  GameCourt? court;
  List<TeamGameAssn> teamGameAssn;
  List<DeviceGameAssn> deviceGameAssn;

  String get formattedStartTime {
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(this.startTime * 1000);
    final DateFormat formatter = DateFormat('jm');
    final String formatted = formatter.format(startTime);
    return formatted;
  }

  String get formattedEndTime {
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(this.endTime * 1000);
    final DateFormat formatter = DateFormat('jm');
    final String formatted = formatter.format(endTime);
    return formatted;
  }

  String get formattedStartDate {
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(this.startTime * 1000);
    return '${startTime.month}.${startTime.day}.${startTime.year}';
  }

  factory GameModel.fromJson(dynamic json) => GameModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      description: json['description'],
      season: json['season'],
      processedVideoUrl: json['processedVideoUrl'],
      league: League.fromJson(json['league']),
      court: json['court'] != null ? GameCourt.fromJson(json['court']) : null,
      teamGameAssn: List<TeamGameAssn>.from(
          json['teamGameAssn'].map((x) => TeamGameAssn.fromJson(x))),
      deviceGameAssn: List<DeviceGameAssn>.from(
          json['deviceGameAssn'].map((x) => DeviceGameAssn.fromJson(x))));
}

class League {
  League(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name});

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  factory League.fromJson(dynamic json) => League(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name']);
}

class GameCourt {
  GameCourt(
      {required this.id, this.createdAt, this.updatedAt, required this.name});

  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String name;

  factory GameCourt.fromJson(dynamic json) => GameCourt(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name']);
}

class GameArena {
  GameArena(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.name,
      required this.courts});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String name;
  List<String> courts;
}

class TeamGameAssn {
  TeamGameAssn(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.designation,
      required this.color,
      required this.team});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String designation;
  String color;
  Team team;

  factory TeamGameAssn.fromJson(dynamic json) => TeamGameAssn(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      designation: json['designation'],
      color: json['color'],
      team: Team.fromJson(json['team']));
}

class Team {
  Team(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.name,
      required this.imageUrl,
      this.deletedAt
      //required this.players,
      //required this.leagues,
      //required this.teamGameAssn,
      //required this.account
      });
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String name;
  String imageUrl;
  //List<Player> players;
  //List<League> leagues;
  //List<String> teamGameAssn;
  //String account;

  factory Team.fromJson(dynamic json) => Team(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      name: json['name'],
      imageUrl: json['imageUrl']);
}

class Player {
  Player(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.name,
      required this.number});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String name;
  String number;

  factory Player.fromJson(dynamic json) => Player(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      name: json['name'],
      number: json['number']);
}

class DeviceGameAssn {
  DeviceGameAssn({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.videoId,
    required this.isActive,
    required this.startTime,
    required this.endTime,
    required this.position,
    required this.game,
    //required this.device
  });
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String videoId;
  bool isActive;
  DateTime startTime;
  DateTime endTime;
  String position;
  String game;
  //Device device;

  factory DeviceGameAssn.fromJson(dynamic json) => DeviceGameAssn(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      videoId: json['videoId'],
      isActive: json['isActive'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      position: json['position'],
      game: json['game']);
}

class Device {
  Device(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.deviceId,
      required this.name,
      required this.account,
      required this.stream,
      required this.gameAssn});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String deviceId;
  String name;
  String account;
  Stream stream;
  List<String> gameAssn;
}

class Stream {
  Stream(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.streamName,
      required this.device});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String streamName;
  String device;
}

class Account {
  Account(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.inactive,
      required this.owner,
      required this.devices,
      required this.members,
      required this.scheduleGames,
      required this.teams});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool inactive;
  Owner owner;
  List<Team> teams;
  List<Member> members;
  List<Device> devices;
  List<String> scheduleGames;
}

class Owner {
  Owner(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.inactive,
      required this.account,
      required this.accountRoleAssn});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String firstName;
  String lastName;
  String email;
  bool inactive;
  String account;
  AccountRoleAssn accountRoleAssn;
}

class AccountRoleAssn {
  AccountRoleAssn(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.accepted,
      required this.user,
      required this.account,
      required this.roles});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool accepted;
  String user;
  String account;
  List<Role> roles;
}

class PlayerProfile {
  PlayerProfile(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.nickName,
      required this.user});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String firstName;
  String lastName;
  String imageUrl;
  String nickName;
  String user;
}

class Role {
  Role(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.role,
      required this.accountMemberAssn});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String role;
  String accountMemberAssn;
}

class Member {
  Member(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.accepted,
      required this.user,
      required this.account,
      required this.roles});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool accepted;
  String user;
  String account;
  List<Role> roles;
}

class Annotation {
  Annotation(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.source,
      required this.s3ETag,
      required this.videoName,
      required this.inputType,
      required this.frameResolution,
      required this.frameRate,
      required this.frameSkip,
      required this.processingWindowOverlap,
      required this.processingWindowSize,
      required this.actions,
      required this.actors,
      required this.scheduleGame});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String source;
  String s3ETag;
  String videoName;
  String inputType;
  String frameResolution;
  int frameRate;
  int frameSkip;
  int processingWindowSize;
  int processingWindowOverlap;
  List<Action> actions;
  List<Actor> actors;
  String scheduleGame;
}

class Action {
  Action(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.action,
      required this.startTime,
      required this.startFrame,
      required this.confidence,
      required this.location,
      required this.qualifiers,
      required this.annotation,
      required this.actor});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String action;
  String startTime;
  int startFrame;
  int confidence;
  String location;
  List<Qualifier> qualifiers;
  String annotation;
  Actor actor;
}

class Qualifier {
  Qualifier(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.qualifier,
      required this.actor});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String qualifier;
  String actor;
}

class Actor {
  Actor(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      required this.identifier,
      required this.type,
      required this.desigination,
      required this.qualifiers,
      required this.actions,
      required this.annotation,
      required this.teamPlayer});
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String identifier;
  String type;
  String desigination;
  List<Qualifier> qualifiers;
  List<String> actions;
  String annotation;
  Player teamPlayer;
}

class GameResponse implements Serializable {
  List<GameModel> games;

  GameResponse({required this.games});

  factory GameResponse.fromJson(List<dynamic> json) => GameResponse(
      games: List<GameModel>.from(json.map((x) => GameModel.fromJson(x))));

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
