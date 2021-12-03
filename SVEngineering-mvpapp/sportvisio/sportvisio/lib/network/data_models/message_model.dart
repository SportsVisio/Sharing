import 'package:sportvisio/network/api_response.dart';

class MessageModel implements Serializable {
  late String message;

  MessageModel({String? message}) {
    message = message != null ? message : "Something went wrong";
  }

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
  }

  @override
  Map<String, dynamic> toJson() {
    return {"message": message};
  }
}
