import 'package:sportvisio/network/api_response.dart';

class GamesResponse extends Serializable {
  late String teamA;
  late String court;
  late String league;
  late String dateTime;
  late String? teams;
  late String teamB;
  late String arena;
  late bool? deleted;

  GamesResponse({
    required this.teamA,
    required this.court,
    required this.league,
    required this.dateTime,
    this.teams,
    required this.teamB,
    required this.arena,
    this.deleted,
  });

  GamesResponse.fromJson(Map<String, dynamic> json) {
    teamA = json['TeamA'];
    court = json['Court'];
    league = json['League'];
    dateTime = json['DateAndTime'] ?? "-";
    teams = json['Teams'];
    teamB = json['TeamB'];
    arena = json['Arena'];
    deleted = json['Deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TeamA'] = this.teamA;
    data['Court'] = this.court;
    data['League'] = this.league;
    data['DateAndTime'] = this.dateTime;
    data['Teams'] = this.teams ?? '${this.teamA} vs ${this.teamB}';
    data['TeamB'] = this.teamB;
    data['Arena'] = this.arena;
    return data;
  }
}
