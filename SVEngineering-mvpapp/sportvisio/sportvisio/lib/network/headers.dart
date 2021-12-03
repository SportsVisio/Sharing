class Headers {
  late String contentType;
  late String accessControlAllowOrigin;

  Headers({required this.contentType, required this.accessControlAllowOrigin});

  Headers.fromJson(Map<String, dynamic> json) {
    contentType = json['Content-Type'];
    accessControlAllowOrigin = json['Access-Control-Allow-Origin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Content-Type'] = this.contentType;
    data['Access-Control-Allow-Origin'] = this.accessControlAllowOrigin;
    return data;
  }
}