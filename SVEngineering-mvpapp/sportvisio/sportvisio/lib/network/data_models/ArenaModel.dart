import 'package:sportvisio/network/api_response.dart';
import 'package:sportvisio/network/data_models/Arena.dart';

class ArenaModel implements Serializable {
  List<Arena> arenas;

  ArenaModel({required this.arenas});

  factory ArenaModel.fromJson(List<dynamic> json) =>
      ArenaModel(arenas: List<Arena>.from(json.map((x) => Arena.fromJson(x))));

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
