class Team {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  String name;
  String imageUrl;

  Team(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.name,
      required this.imageUrl});

  factory Team.fromJson(dynamic json) => Team(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deleteAt']) : null,
      name: json['name'],
      imageUrl: json['imageUrl']);
}
