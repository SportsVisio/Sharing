import 'package:sportvisio/network/api_response.dart';

class League {
  late String id;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String name;

  League(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['Name'] = this.name;
    return data;
  }
}

class LeagueModel implements Serializable {
  List<League> leagues;

  LeagueModel({required this.leagues});

  factory LeagueModel.fromJson(List<dynamic> json) => LeagueModel(
      leagues: List<League>.from(json.map((x) => League.fromJson(x))));

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
