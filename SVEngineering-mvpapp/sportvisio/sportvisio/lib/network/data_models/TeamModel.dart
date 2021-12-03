import 'package:sportvisio/network/api_response.dart';

import 'Team.dart';

class TeamModel implements Serializable {
  List<Team> teams;

  TeamModel({required this.teams});

  factory TeamModel.fromJson(List<dynamic> json) =>
      TeamModel(teams: List<Team>.from(json.map((x) => Team.fromJson(x))));

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
