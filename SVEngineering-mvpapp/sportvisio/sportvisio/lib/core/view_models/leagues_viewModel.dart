import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/view_models/base_viewModel.dart';
import 'package:sportvisio/network/data_models/LeagueModelNew.dart';
import 'package:sportvisio/network/data_models/league_model.dart';
import 'package:sportvisio/network/data_models/message_model.dart';
import 'package:sportvisio/network/leagues_api_service.dart';

class LeaguesViewModel extends BaseViewModel {
  LeaguesApiService _leaguesApiService = locator.get<LeaguesApiService>();

  late List<LeaguesResponse> _leaguesResponses = [];
  MessageModel? _createLeagueResponse;
  MessageModel? _updateLeagueResponse;
  MessageModel? _deleteLeagueResponse;
  Map<String, dynamic>? _payload;
  List<League> _gamesNew = [];
  String _token = '';

  Map<String, dynamic>? get payload => _payload;

  List<LeaguesResponse> get leaguesResponses => _leaguesResponses;

  LeaguesViewModel() {
    this.setToken().then((value) {
      getLeagues();
    });
  }

  Future<List<League>> getLeaguesNew() async {
    await setToken();
    setLoading();
    try {
      _gamesNew = await _leaguesApiService.getLeaguesNew(_token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return _gamesNew;
  }

  Future<MessageModel> getLeagueNew(id) async {
    late MessageModel league;
    setLoading();
    try {
      league = await _leaguesApiService.getLeagueNew(_token, id);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return league;
  }

  Future<bool> updateLeagueNew(id, payload) async {
    bool updated = false;
    setLoading();
    try {
      updated = await _leaguesApiService.updateLeagueNew(_token, id, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return updated;
  }

  Future<MessageModel> deleteLeagueNew(id) async {
    late MessageModel response;
    setLoading();
    try {
      response = await _leaguesApiService.deleteLeagueNew(_token, id);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return response;
  }

  Future<MessageModel> createLeagueNew(payload) async {
    late MessageModel created;
    setLoading();
    try {
      created = await _leaguesApiService.createLeagueNew(_token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return created;
  }

  Future<List<LeaguesResponse>> getLeagues() async {
    setLoading();
    try {
      _leaguesResponses = await _leaguesApiService.getLeagues();
      setCompleted();
    } catch (e) {
      print('error fetching leagues: $e');
      setError(e);
    }
    return _leaguesResponses;
  }

  void getLeaguesKeyword(payload) async {
    setLoading();
    try {
      _leaguesResponses = await _leaguesApiService.getLeaguesKeyword(payload);
      setCompleted();
    } catch (e) {
      print('error fetching leagues: $e');
      setError(e);
    }
  }

  Future<MessageModel?> createLeague(payload) async {
    setLoading();
    try {
      _createLeagueResponse = await _leaguesApiService.createLeague(payload);
      setCompleted();
    } catch (e) {
      print('error creating league: $e');
      setError(e);
    }
    return _createLeagueResponse;
  }

  Future<MessageModel?> deleteLeague(payload) async {
    setLoading();
    try {
      _deleteLeagueResponse = await _leaguesApiService.deleteLeague(payload);
      setCompleted();
    } catch (e) {
      print('error creating league: $e');
      setError(e);
    }
    return _deleteLeagueResponse;
  }

  Future<MessageModel?> createTeam(payload) async {
    setLoading();
    try {
      _createLeagueResponse = await _leaguesApiService.createTeam(payload);
      setCompleted();
    } catch (e) {
      print('error creating team: $e');
      setError(e);
    }
    return _createLeagueResponse;
  }

  void setPayload(Map<String, dynamic> payload) {
    _payload = payload;
  }

  deleteTeam(payload) async {
    setLoading();
    try {
      _deleteLeagueResponse = await _leaguesApiService.deleteTeam(payload);
      setCompleted();
    } catch (e) {
      print('error delete team: $e');
      setError(e);
    }
    return _deleteLeagueResponse;
  }

  Future<MessageModel?> updateLeague(payload) async {
    setLoading();
    try {
      _updateLeagueResponse = await _leaguesApiService.updateLeague(payload);
      setCompleted();
    } catch (e) {
      print('error updating league: $e');
      setError(e);
    }
    return _updateLeagueResponse;
  }

  Future<MessageModel?> updateLeagueName(payload) async {
    return await updateLeague(payload);
  }

  Future<MessageModel?> updateLeagueTeam(payload) async {
    return await updateTeam(payload);
  }

  Future<MessageModel?> updateLeaguePlayer(payload) async {
    return await updateLeague(payload);
  }

  updateTeam(payload) async {
    setLoading();
    try {
      _updateLeagueResponse = await _leaguesApiService.updateTeam(payload);
      setCompleted();
    } catch (e) {
      print('error updating league: $e');
      setError(e);
    }
    return _updateLeagueResponse;
  }

  deletePlayer(payload) async {
    setLoading();
    try {
      _deleteLeagueResponse = await _leaguesApiService.deletePlayer(payload);
      setCompleted();
    } catch (e) {
      print('error delete team: $e');
      setError(e);
    }
    return _deleteLeagueResponse;
  }

  Future<String?> setToken() async {
    if (_token.isEmpty) {
      var pref = await SharedPreferences.getInstance();
      _token = pref.getString("token")!;
    }
    return _token;
  }
}
