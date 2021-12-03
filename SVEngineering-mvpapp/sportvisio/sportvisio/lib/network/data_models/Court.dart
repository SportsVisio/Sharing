class Court {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  String name;

  Court(
      {required this.id,
      required this.createdAt,
      this.deletedAt,
      required this.name,
      required this.updatedAt});

  @override
  String toString() {
    return name;
  }

  factory Court.fromJson(dynamic json) => Court(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deleteAt']) : null,
      name: json['name'],
      updatedAt: DateTime.parse(json['updatedAt']));
}
