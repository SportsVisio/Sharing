import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/view_models/base_viewModel.dart';
import 'package:sportvisio/network/arena_api_service.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/Court.dart';

class ArenaViewModel extends BaseViewModel {
  ArenasApiService _arenaApiService = locator.get<ArenasApiService>();
  late List<Arena> _arenas = [];
  String _token = '';
  List<Arena> get arenas => _arenas;

  ArenaViewModel() {
    this.setToken().then((value) {
      getArenas();
    });
  }

  Future<String?> setToken() async {
    if (_token.isEmpty) {
      var pref = await SharedPreferences.getInstance();
      _token = pref.getString("token")!;
    }
    return _token;
  }

  Future<List<Arena>> getArenasKeyword(payload, bool searchCourts) async {
    List<Arena> searchResults = [];
    setLoading();
    try {
      List<Arena> arenas = await _arenaApiService.getArenas(_token);
      searchResults.addAll(arenas
          .where((arena) => arena.name
              .toLowerCase()
              .contains(payload.toString().toLowerCase()))
          .toList());
      if (searchCourts) {
        arenas.forEach((arena) {
          var courts = arena.courts;
          for (Court court in courts) {
            if (court.name
                .toLowerCase()
                .contains(payload.toString().toLowerCase())) {
              searchResults.add(arena);
              break;
            }
          }
        });
      }
      _arenas = searchResults.toSet().toList();
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return searchResults;
  }

  Future<Court> getCourt(id) async {
    late Court court;
    setLoading();
    try {
      court = await _arenaApiService.getCourt(id, _token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return court;
  }

  Future<List<Arena>> getArenas() async {
    await setToken();
    setLoading();
    try {
      _arenas = await _arenaApiService.getArenas(_token);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return _arenas;
  }

  Future<Arena?> createArena(payload) async {
    Arena? arena;
    setLoading();
    try {
      arena = await _arenaApiService.createArena(_token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return arena;
  }

  Future<bool?> createCourtNew(arenaId, payload) async {
    bool? created;
    setLoading();
    try {
      created = await _arenaApiService.createCourt(arenaId, _token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return created;
  }

  Future<bool?> deleteCourt(payload) async {
    bool? deleted;
    setLoading();
    try {
      deleted = await _arenaApiService.deleteCourt(_token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return deleted;
  }

  Future<bool?> deleteArena(payload) async {
    bool? response;
    setLoading();
    try {
      response = await _arenaApiService.deleteArena(_token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return response;
  }

  Future<bool?> updateArena(arenaId, payload) async {
    bool? updated;
    setLoading();
    try {
      updated = await _arenaApiService.updateArena(arenaId, _token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return updated;
  }

  Future<bool?> updateCourt(courtId, payload) async {
    bool? updated;
    setLoading();
    try {
      updated = await _arenaApiService.updateCourt(courtId, _token, payload);
      setCompleted();
    } catch (e) {
      setError(e);
    }
    return updated;
  }
}
