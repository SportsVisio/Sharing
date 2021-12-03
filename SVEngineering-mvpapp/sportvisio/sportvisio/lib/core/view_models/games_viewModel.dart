import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/constants/api_endpoints.dart';
import 'package:sportvisio/core/view_models/base_viewModel.dart';
import 'package:sportvisio/network/data_models/GameModelNew.dart';
import 'package:sportvisio/network/data_models/message_model.dart';
import 'package:sportvisio/network/games_api_service.dart';
import 'package:http/http.dart' as http;

class GamesViewModel extends BaseViewModel {
  GamesApiService _gamesApiService = locator.get<GamesApiService>();
  String _token = '';
  List<GameModel> _gamesNew = [];
  late MessageModel _gameNew;
  List<GameModel> get gameResponses => _gamesNew;

  GamesViewModel() {
    this.setToken().then((value) {
      getGamesNew();
    });
  }

  Future<List<GameModel?>> getGamesNew() async {
    await this.setToken();
    setLoading();
    try {
      _gamesNew = await _gamesApiService.getGames(_token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return _gamesNew;
  }

  Future<List<GameModel>> getGamesNewKeyword(keyword) async {
    List<GameModel> searchResults = [];
    setLoading();
    try {
      List<GameModel> games = await _gamesApiService.getGames(_token);
      if (keyword.toString() == '@') {
        searchResults.addAll(games);
      } else {
        searchResults.addAll(games
            .where((game) => game.formattedStartTime
                .contains(keyword.toString().toLowerCase()))
            .toList());
        searchResults.addAll(games
            .where((game) => game.formattedEndTime
                .contains(keyword.toString().toLowerCase()))
            .toList());
        searchResults.addAll(games
            .where((game) => game.formattedStartDate
                .contains(keyword.toString().toLowerCase()))
            .toList());
        searchResults.addAll(games
            .where((game) => game.teamGameAssn[0].team.name
                .toLowerCase()
                .contains(keyword.toString().toLowerCase()))
            .toList());
        searchResults.addAll(games
            .where((game) => game.teamGameAssn[1].team.name
                .toLowerCase()
                .contains(keyword.toString().toLowerCase()))
            .toList());
        _gamesNew = searchResults.toSet().toList();
      }
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return searchResults;
  }

  Future<MessageModel> getGameNew(id) async {
    setLoading();
    try {
      _gameNew = await _gamesApiService.getGame(id, _token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return _gameNew;
  }

  Future<bool> updateGameNew(id, payload) async {
    bool updated = false;
    setLoading();
    try {
      updated = await _gamesApiService.updateGame(id, payload, _token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return updated;
  }

  Future<MessageModel> createGameNew(payload) async {
    late MessageModel created;
    setLoading();
    try {
      created = await _gamesApiService.createGame(payload, _token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return created;
  }

  Future<bool> deleteGameNew(id) async {
    bool deleted = false;
    setLoading();
    try {
      deleted = await _gamesApiService.deleteGame(id, _token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return deleted;
  }

  Future<String?> setToken() async {
    if (_token.isEmpty) {
      var pref = await SharedPreferences.getInstance();
      _token = pref.getString("token")!;
    }
    return _token;
  }

  Future<http.Response> registerDevice(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.REGISTERDEVICE),
          headers: headers, body: payload);

      setCompleted();
    } catch (e) {
      print('error excchange: $e');
      setError(e);
    }
    return jsonRespose;
  }

  Future<http.Response> SheduleGame(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.GAMESCHEDULE),
          headers: headers, body: payload);

      setCompleted();
    } catch (e) {
      print('error excchange: $e');
      setError(e);
    }
    return jsonRespose;
  }
}
