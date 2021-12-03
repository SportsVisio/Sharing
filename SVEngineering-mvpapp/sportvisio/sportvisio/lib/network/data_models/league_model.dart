import 'package:sportvisio/network/api_response.dart';
import 'package:uuid/uuid.dart';

class Player {
  late String name;
  late String number;

  Player({required this.name, required this.number});
}

class Team {
  late Uuid id;
  late String name;
  late List<Player> players;

  Team({required this.name, required this.players, required this.id});
}

class LeaguesResponse implements Serializable {
  late String league;
  late bool deleted;
  late List<Team> teams;
  late List<Team> teamsAdd;
  late List<Team> teamsRemove;

  LeaguesResponse(
      {required this.league,
      required this.deleted,
      required this.teams,
      this.teamsAdd = const [],
      this.teamsRemove = const []});

  LeaguesResponse.fromJson(Map<String, dynamic> json) {
    league = json['League'];
    deleted = json['Deleted'];
    List<Team> _teams = [];
    json['Teams'].forEach((_name, _players) {
      Team team = Team(
        name: _name,
        players: [],
        id: Uuid(),
      );
      _players.forEach((playerName, value) {
        team.players.add(Player(name: playerName, number: value["Number"]));
      });
      _teams.add(team);
    });
    teams = _teams;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['League'] = this.league;
    data['Deleted'] = this.deleted;
    // data['Team'] = this.team;
    return data;
  }
}
