class Headers {
  Headers({
    required this.contentType,
    required this.accessControlAllowOrigin,
  });

  String contentType;
  String accessControlAllowOrigin;

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
        contentType: json["Content-Type"],
        accessControlAllowOrigin: json["Access-Control-Allow-Origin"],
      );

  Map<String, dynamic> toJson() => {
        "Content-Type": contentType,
        "Access-Control-Allow-Origin": accessControlAllowOrigin,
      };
}
