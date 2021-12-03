import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/constants/api_endpoints.dart';
import 'package:sportvisio/core/helpers/api_helper.dart';
import 'package:sportvisio/network/api_response.dart';
import 'package:sportvisio/network/data_models/league_model.dart';
import 'package:sportvisio/network/data_models/message_model.dart';

import 'data_models/LeagueModelNew.dart';

abstract class LeaguesApi {
  Future<List<League>> getLeaguesNew(token);
  Future<MessageModel> getLeagueNew(token, id);
  Future<bool> updateLeagueNew(token, id, payload);
  Future<MessageModel> deleteLeagueNew(token, id);
  Future<MessageModel> createLeagueNew(token, payload);

  Future<List<LeaguesResponse>> getLeagues();

  getLeaguesKeyword(payload);

  Future<MessageModel?> createLeague(payload);

  Future<MessageModel?> createTeam(payload);

  deleteLeague(payload);

  deleteTeam(payload);

  updateLeague(payload);
  updateTeam(payload);
  deletePlayer(payload);
}

@lazySingleton
class LeaguesApiService implements LeaguesApi {
  ApiHelper _apiService = locator.get<ApiHelper>();

  Future<List<League>> getLeaguesNew(token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_LEAGUES_NEW,
        useSwagger: true, options: options);
    var response = LeagueModel.fromJson(json);
    return response.leagues;
  }

  Future<MessageModel> getLeagueNew(token, id) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_LEAGUE_NEW + id,
        useSwagger: true, options: options);
    //var arenaResponse = ArenaResponseNew.fromJson(json);
    return MessageModel();
  }

  @override
  Future<MessageModel> createLeagueNew(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.post(ApiEndPoints.CREATE_GAME_NEW,
        useSwagger: true, data: payload, options: options);
    //var arena = Arena.fromJson(json);
    return MessageModel();
  }

  @override
  Future<bool> updateLeagueNew(token, id, payload) async {
    bool updated = false;
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    updated = await _apiService.put(ApiEndPoints.UPDATE_LEAGUES_NEW + id,
        useSwagger: true, data: payload, options: options);
    return updated;
  }

  @override
  Future<MessageModel> deleteLeagueNew(token, id) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.delete(ApiEndPoints.DELETE_LEAGUES_NEW + id,
        useSwagger: true, options: options);
    return MessageModel();
  }

  @override
  Future<List<LeaguesResponse>> getLeagues() async {
    final json = await _apiService.get(ApiEndPoints.GET_LEAGUES);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => LeaguesResponse.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<LeaguesResponse>();
    }
    return [];
  }

  @override
  getLeaguesKeyword(payload) async {
    final json =
        await _apiService.post(ApiEndPoints.GET_LEAGUES_KEYWORD, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => LeaguesResponse.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<LeaguesResponse>();
    }
    return [];
  }

  @override
  Future<MessageModel?> createLeague(payload) async {
    final json =
        await _apiService.post(ApiEndPoints.CREATE_LEAGUE, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }

  @override
  Future<MessageModel?> updateLeague(payload) async {
    final json =
        await _apiService.post(ApiEndPoints.UPDATE_LEAGUE, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }

  Future<MessageModel?> deleteLeague(payload) async {
    final json =
        await _apiService.delete(ApiEndPoints.DELETE_LEAGUE, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }

  @override
  Future<MessageModel?> createTeam(payload) async {
    final json =
        await _apiService.post(ApiEndPoints.CREATE_TEAM, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }

  @override
  deleteTeam(payload) async {
    final json =
        await _apiService.delete(ApiEndPoints.DELETE_TEAM, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }

  @override
  updateTeam(payload) async {
    final json =
        await _apiService.post(ApiEndPoints.UPDATE_TEAM, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }

  @override
  deletePlayer(payload) async {
    final json =
        await _apiService.delete(ApiEndPoints.DELETE_PLAYER, data: payload);
    ApiResponse apiResponse = _apiService.parseJson(
      json,
      modelCreator: (json) => MessageModel.fromJson(json),
    );
    if (apiResponse.statusCode == 200) {
      return apiResponse.body!.cast<MessageModel>().elementAt(0);
    }
    return null;
  }
}
