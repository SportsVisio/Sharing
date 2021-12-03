import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/constants/api_endpoints.dart';
import 'package:sportvisio/core/helpers/api_helper.dart';

import 'data_models/Team.dart';
import 'data_models/TeamModel.dart';

abstract class TeamApi {
  Future<List<Team>> getTeams(token);
}

@lazySingleton
class TeamsApiService implements TeamApi {
  ApiHelper _apiService = locator.get<ApiHelper>();

  @override
  Future<List<Team>> getTeams(token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var options = Options(headers: headers);
    final json = await _apiService.get(ApiEndPoints.GET_TEAMS,
        useSwagger: true, options: options);
    var response = TeamModel.fromJson(json);
    return response.teams;
  }
}
