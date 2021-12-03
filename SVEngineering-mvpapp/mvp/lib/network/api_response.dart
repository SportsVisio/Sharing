import 'headers.dart';

abstract class Serializable {
  Map<String, dynamic> toJson();
}

class ApiResponse<T extends Serializable> {
  int? statusCode;
  Headers? headers;
  List<T>? body;
  bool? isBase64Encoded;

  ApiResponse({
    this.statusCode,
    this.headers,
    this.body,
    this.isBase64Encoded,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    required Function(dynamic) bodyParser,
  }) {
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      headers: Headers.fromJson(json['headers']),
      isBase64Encoded: json['isBase64Encoded'],
      body: bodyParser(json['body']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": this.statusCode,
      "headers": this.headers?.toJson(),
      "body": this.body,
      "isBase64Encoded": this.isBase64Encoded,
    };
  }
}
