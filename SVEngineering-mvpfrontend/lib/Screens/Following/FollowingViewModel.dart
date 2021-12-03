import 'package:flutter/cupertino.dart';
import 'package:mvp/Screens/AddPlayer/model/AllTeamsModel.dart';
import 'package:mvp/Screens/Following/model/FollowedPlayerProfileModel.dart';
import 'package:mvp/Screens/Following/model/PlayerModel.dart';
import 'package:mvp/Screens/Following/model/PlayerProfileModel.dart';
import 'package:http/http.dart' as http;
import 'package:mvp/Screens/Following/model/StatsModel.dart';
import 'package:mvp/core/constants/PreferencesManager.dart';
import 'package:mvp/core/constants/api_endpoints.dart';

class FollowingViewModel extends ChangeNotifier {
  bool isShowList = true;
  bool isPlayerClick = false;
  bool isAddVsPlayerClick = false;
  bool isTeamLifeLong = false;
  PlayerModel? selectedTeamModel;
  bool isSpecificGameSearch = false;
  bool isChooseVSGameCalender = false;
  bool isSelectGameFromCalender = false;
  PlayerProfileModel? playerProfileModel;
  bool _isLaoding = false;
  bool get isLoading => _isLaoding;
  bool _isLaodingAllTeams = false;
  bool get isLoadingAllTeams => _isLaodingAllTeams;
  List<FollowedPlayerProfileModel> listFollowedPlayers = [];
  StatsModel? statsModel;
  List<AllTeamsModel> allTeamsList = [];

  void changeWidget({var key, var selectedTeam}) {
    if (key == "list") {
      isShowList = true;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = false;
    }
    if (key == "playerClick") {
      isShowList = false;
      isPlayerClick = true;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = false;
    }
    if (key == "addvsplayerclick") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = true;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = false;
    }

    if (key == "teamlifelongresult") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = true;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      selectedTeamModel = null;
      isSelectGameFromCalender = false;

      selectedTeamModel = selectedTeam;
    }
    if (key == "specificgamesearchteam") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = true;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = false;
    }
    if (key == "choosevsgamecalender") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = true;
      isSelectGameFromCalender = false;
    }
    if (key == "choosevsgdamecalender") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = true;
      isSelectGameFromCalender = false;
    }
    if (key == "selectgamefromcalender") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = true;
    }
    if (key == "selectgamefromPlayer") {
      isShowList = false;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = true;
    }
    if (key == "back") {
      isShowList = true;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
      isTeamLifeLong = false;
      isSpecificGameSearch = false;
      isChooseVSGameCalender = false;
      isSelectGameFromCalender = false;
    }
    notifyListeners();
  }

  Future getPlayerProfile() async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose = await http.get(Uri.parse(ApiEndPoints.GETPLAYERPROFILE),
          headers: headers);
      if (jsonRespose.statusCode == 200) {
        playerProfileModel =
            playerProfileModelFromJson(jsonRespose.body.toString());
        print(playerProfileModel!.id.toString());
      }
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future getFollowedProfiles() async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose = await http
          .get(Uri.parse(ApiEndPoints.GETFOLLOWEDPROFILES), headers: headers);
      if (jsonRespose.statusCode == 200) {
        listFollowedPlayers =
            followedPlayerProfileModelFromJson(jsonRespose.body.toString());

        print(listFollowedPlayers.length.toString() + ")))))");
      }
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future FollowPlayer(var profileId) async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose = await http.post(
          Uri.parse(ApiEndPoints.FOLLOWAPLAYER + "/$profileId"),
          headers: headers);
      if (jsonRespose.statusCode == 200) {}
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future UNFollowPlayer(var profileId) async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose = await http.delete(
          Uri.parse(ApiEndPoints.UNFOLLOWAPLAYER + "/$profileId"),
          headers: headers);
      if (jsonRespose.statusCode == 200) {}
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future claimTeamPlayer(var playerId) async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose = await http.post(
          Uri.parse(ApiEndPoints.CLAIMTEAMPLAYER + "/$playerId"),
          headers: headers);
      if (jsonRespose.statusCode == 200) {}
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future getStats() async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose =
          await http.post(Uri.parse(ApiEndPoints.GETSTATS), headers: headers);
      if (jsonRespose.statusCode == 200) {
        statsModel = statsModelFromJson(jsonRespose.body);
      }
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future searchProfile(var searchedData) async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaoding = true;
    notifyListeners();

    try {
      var jsonRespose = await http.post(Uri.parse(ApiEndPoints.SEARCHPROFILE),
          headers: headers, body: {"search": searchedData});
      if (jsonRespose.statusCode == 200) {}
      _isLaoding = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaoding = false;
      notifyListeners();
    }
  }

  Future getAllTeams() async {
    final List<String?> authInformation =
        await PreferencesManager.getPreferences;
    var client = http.Client();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${authInformation[0].toString()}',
    };

    var jsonRespose;
    _isLaodingAllTeams = true;
    notifyListeners();

    try {
      var jsonRespose =
          await http.get(Uri.parse(ApiEndPoints.GETALLTEAMS), headers: headers);
      if (jsonRespose.statusCode == 200) {
        allTeamsList = allTeamsModelFromJson(jsonRespose.body.toString());
      }
      _isLaodingAllTeams = false;
      notifyListeners();
    } catch (e) {
      print('error login: $e');
      _isLaodingAllTeams = false;
      notifyListeners();
    }
  }
}
