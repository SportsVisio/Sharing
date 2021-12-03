import 'package:sportvisio/network/data_models/Court.dart';

class Arena {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  String name;
  List<Court> courts;

  Arena(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.name,
      required this.courts});

  factory Arena.fromJson(dynamic json) => Arena(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deleteAt']) : null,
      name: json['name'],
      courts: List<Court>.from(json['courts'].map((x) => Court.fromJson(x))));
}
