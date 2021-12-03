import 'package:sportvisio/network/api_response.dart';

class TeamUpdateResponse extends Serializable {
  late String newLeague;
  late String oldLeague;
  late String newTeam;
  late String oldTeam;
  late List<String> oldPlayers;
  late List<String> newlayers;
  late List<String> playersNumbers;
  late List<String> deletedPlayers;

  TeamUpdateResponse(
      {required this.newLeague,
      required this.newTeam,
      required this.newlayers,
      required this.oldLeague,
      required this.oldPlayers,
      required this.oldTeam,
      required this.playersNumbers,
      required this.deletedPlayers});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['League'] = this.oldLeague;
    data['NewLeague'] = this.newLeague;
    data['Team'] = this.oldTeam;
    data['NewTeam'] = this.newTeam;
    data['Player'] = this.oldPlayers;
    data['NewPlayer'] = this.newlayers;
    data['Number'] = this.playersNumbers;
    return data;
  }
}
