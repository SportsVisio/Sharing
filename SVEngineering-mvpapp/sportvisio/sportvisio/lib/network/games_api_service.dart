import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/constants/api_endpoints.dart';
import 'package:sportvisio/core/helpers/api_helper.dart';
import 'package:sportvisio/network/data_models/message_model.dart';
import 'data_models/GameModelNew.dart';
import 'data_models/RegisterDeviceModel.dart';

abstract class GamesApi {
  Future<List<GameModel?>> getGames(token);
  Future<MessageModel> getGame(id, token);
  Future<bool> updateGame(id, payload, token);
  Future<MessageModel> createGame(payload, token);
  Future<bool> deleteGame(id, token);
}

@lazySingleton
class GamesApiService implements GamesApi {
  ApiHelper _apiService = locator.get<ApiHelper>();

  @override
  Future<List<GameModel>> getGames(token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_GAMES_NEW,
        useSwagger: true, options: options);
    var response = GameResponse.fromJson(json);
    return response.games;
  }

  @override
  Future<MessageModel> getGame(id, token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var params = {'scheduledGameId': id};
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_GAME_NEW,
        useSwagger: true, queryParameters: params, options: options);
    //var arenaResponse = ArenaResponseNew.fromJson(json);
    return MessageModel();
  }

  @override
  Future<bool> updateGame(id, payload, token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.put(ApiEndPoints.UPDATE_GAME_NEW + id,
        useSwagger: true, data: payload, options: options);
    return json.toString().toLowerCase() == 'true';
  }

  @override
  Future<MessageModel> createGame(payload, token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.post(ApiEndPoints.CREATE_GAME_NEW,
        useSwagger: true, data: payload, options: options);
    return MessageModel();
  }

  @override
  Future<bool> deleteGame(id, token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.delete(ApiEndPoints.DELETE_GAMES_NEW + id,
        useSwagger: true, options: options);
    return json.toString().toLowerCase() == 'true';
  }

  Future<RegisterDeviceModel?> registerDevice(payload) async {
    final json = await _apiService.post(
      ApiEndPoints.REGISTERDEVICE,
      data: payload,
    );
    RegisterDeviceModel model = registerDeviceModelFromJson(json.body);
    return model;
  }

  unRegisterDevice(payload) {
    throw UnimplementedError();
  }
}
