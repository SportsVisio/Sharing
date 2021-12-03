import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/constants/api_endpoints.dart';
import 'package:sportvisio/core/helpers/api_helper.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'data_models/ArenaModel.dart';
import 'data_models/Court.dart';

abstract class ArenaApi {
  Future<bool?> createCourt(arenaId, token, payload);
  Future<List<Arena>> getArenas(token);
  Future<Arena?> createArena(token, payload);
  Future<bool?> deleteArena(token, payload);
  Future<bool?> updateArena(arenaId, token, payload);
  Future<bool?> deleteCourt(token, payload);
  Future<bool?> updateCourt(courtId, token, payload);
  Future<Court> getCourt(courtId, token);
}

@lazySingleton
class ArenasApiService implements ArenaApi {
  ApiHelper _apiService = locator.get<ApiHelper>();

  @override
  Future<Court> getCourt(id, token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_COURT + id,
        useSwagger: true, options: options);
    var court = Court.fromJson(json);
    return court;
  }

  @override
  Future<List<Arena>> getArenas(token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_ARENAS,
        useSwagger: true, options: options);
    var arenaResponse = ArenaModel.fromJson(json);
    return arenaResponse.arenas;
  }

  @override
  Future<Arena?> createArena(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.post(ApiEndPoints.CREATE_ARENA,
        useSwagger: true, data: payload, options: options);
    var arena = Arena.fromJson(json);
    return arena;
  }

  @override
  Future<bool?> updateArena(arenaId, token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.put(ApiEndPoints.UPDATE_ARENA + arenaId,
        useSwagger: true, data: payload, options: options);
    return json.toString().toLowerCase() == 'true';
  }

  @override
  Future<bool?> deleteArena(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.delete(ApiEndPoints.DELETE_ARENA + payload,
        useSwagger: true, data: payload, options: options);
    return json.toString().toLowerCase() == 'true';
  }

  @override
  Future<bool?> createCourt(arenaId, token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.post(ApiEndPoints.CREATE_COURT + arenaId,
        useSwagger: true, data: payload, options: options);
    return json.toString().toLowerCase() == 'true';
  }

  @override
  Future<bool?> deleteCourt(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.delete(ApiEndPoints.DELETE_COURT + payload,
        useSwagger: true, data: payload, options: options);
    return json.toString().toLowerCase() == 'true';
  }

  @override
  Future<bool?> updateCourt(courtId, token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    var json = await _apiService.put(ApiEndPoints.UPDATE_COURT + courtId,
        useSwagger: true, data: payload, options: options);
    return json.toString().toLowerCase() == 'true';
  }
}
