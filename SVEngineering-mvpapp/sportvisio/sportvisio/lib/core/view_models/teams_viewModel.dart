import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/view_models/base_viewModel.dart';
import 'package:sportvisio/network/teams_api_service.dart';
import 'package:sportvisio/network/data_models/Team.dart';

class TeamsViewModel extends BaseViewModel {
  TeamsApiService _teamApiService = locator.get<TeamsApiService>();
  late List<Team> _teams = [];
  String _token = '';

  List<Team> get teams => _teams;

  TeamsViewModel() {
    this.setToken().then((value) {
      getTeams();
    });
  }

  Future<String?> setToken() async {
    if (_token.isEmpty) {
      var pref = await SharedPreferences.getInstance();
      _token = pref.getString("token")!;
    }
    return _token;
  }

  Future<List<Team>> getTeams() async {
    await this.setToken();
    setLoading();
    try {
      _teams = await _teamApiService.getTeams(_token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return _teams;
  }
}
