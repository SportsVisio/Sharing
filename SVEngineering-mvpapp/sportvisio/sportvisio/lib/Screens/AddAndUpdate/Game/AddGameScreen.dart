import 'package:sportvisio/Widgets/loading_widget.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/network/data_models/Team.dart' as teams;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Arena/AddArenaScreen.dart';
import 'package:sportvisio/Widgets/background_icons/background_icon_add.dart';
import 'package:sportvisio/Widgets/buttons/primary_button.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/sportsvisio_drop_down_with_add_button.dart';
import 'package:sportvisio/Widgets/sportsvisio_drop_down.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/core/view_models/games_viewModel.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/core/view_models/teams_viewModel.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/Court.dart';
import 'package:sportvisio/network/data_models/GameModelNew.dart';
import 'package:sportvisio/network/data_models/LeagueModelNew.dart' as leagues;

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({Key? key}) : super(key: key);

  @override
  _AddGameScreenState createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  final _formKey = GlobalKey<FormState>();
  final _timeController = TextEditingController();
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();

  final _arenaController = TextEditingController();
  Arena? _arena = null;
  List<Arena> _arenas = [];
  final _courtController = TextEditingController();
  Court? _court = null;
  List<Court> _courts = [];

  leagues.League? _league = null;
  List<leagues.League> _leagues = [];
  final _leagueController = TextEditingController();

  List<teams.Team> _teams = [];
  teams.Team? _teamA = null;
  teams.Team? _teamB = null;

  DateTime? _startTime;
  DateTime? _endTime;
  DateTime? _startDate;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<LeaguesViewModel>(context, listen: false)
        .getLeaguesNew()
        .then((value) {
      _leagues = value;
      if (value.length == 1) {
        _league = _leagues[0];
      }
      Provider.of<TeamsViewModel>(context, listen: false)
          .getTeams()
          .then((value) {
        _teams = value;
        Provider.of<ArenaViewModel>(context, listen: false)
            .getArenas()
            .then((value) {
          _arenas = value;
          if (value.length == 1) {
            _arena = value[0];
            _courts = value[0].courts;
            if (_courts.length == 1) {
              _court = value[0].courts[0];
            }
          }
          setState(() {
            _arenas;
            _arena;
            _courts;
            _court;
            _leagues;
            _league;
            _teams;
            _isLoading = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#DCF9E1"),
      body: Stack(
        children: [
          BackgroundIconAdd(),
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: size.height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Spacer(),
                      Text(
                        'Add Game',
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      UIHelper.verticalSpace30,
                      SportsVisioDropdown(
                        validator: (String? date) {
                          if (date == null || date.isEmpty)
                            return "Select a Date";
                          else
                            return null;
                        },
                        isAddButton: false,
                        hint: "Date/Time",
                        onTapDown: () {
                          print('on tap down');
                          _showDatePicker();
                        },
                        onTapAdd: () {
                          print('on tap add');
                        },
                        controller: _timeController,
                        isRequired: true,
                      ),
                      UIHelper.verticalSpaceSm,
                      SportsVisioDropDownWithAddButton<leagues.League>(
                          showClearButton: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (leagues.League? league) {
                            if (league == null)
                              return "Select a League";
                            else
                              return null;
                          },
                          items: _leagues,
                          selectedItem: _league,
                          filterFn: (league, filter) =>
                              this.searchLeagues(league, filter),
                          searchBoxController: _leagueController,
                          hintText: 'League',
                          itemAsString: (league) => league.name,
                          onChanged: (league) {
                            if (league != null) {
                              setState(() {
                                _league = league;
                              });
                            } else {
                              setState(() {
                                _league = null;
                              });
                            }
                          },
                          //showAddButton: true,
                          onAddPress: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddArenaScreen(),
                                ));
                            if (result != null) {}
                          }),
                      UIHelper.verticalSpaceSm,
                      SportsVisioDropDownWithAddButton<teams.Team>(
                          showClearButton: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (teams.Team? team) {
                            if (team == null)
                              return "Select a Team";
                            else
                              return null;
                          },
                          selectedItem: _teamA,
                          filterFn: (team, filter) =>
                              this.searchTeam(team, filter),
                          searchBoxController: _teamAController,
                          hintText: 'Team A',
                          items: _teams,
                          itemAsString: (team) => team.name,
                          onChanged: (team) {
                            if (team != null) {
                              setState(() {
                                _teamA = team;
                              });
                            } else {
                              setState(() {
                                _teamA = null;
                              });
                            }
                          },
                          //showAddButton: true,
                          onAddPress: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddArenaScreen(),
                                ));
                            if (result != null) {}
                          }),
                      UIHelper.verticalSpaceSm,
                      SportsVisioDropDownWithAddButton<teams.Team>(
                          showClearButton: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (teams.Team? team) {
                            if (team == null)
                              return "Select a Team";
                            else
                              return null;
                          },
                          selectedItem: _teamB,
                          filterFn: (team, filter) =>
                              this.searchTeam(team, filter),
                          searchBoxController: _teamBController,
                          hintText: 'Team B',
                          items: _teams,
                          itemAsString: (team) => team.name,
                          onChanged: (team) {
                            if (team != null) {
                              setState(() {
                                _teamB = team;
                              });
                            } else {
                              setState(() {
                                _teamB = null;
                              });
                            }
                          },
                          //showAddButton: true,
                          onAddPress: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddArenaScreen(),
                                ));
                            if (result != null) {}
                          }),
                      UIHelper.verticalSpaceSm,
                      SportsVisioDropDownWithAddButton<Arena>(
                        showClearButton: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (Arena? arena) {
                          if (arena == null)
                            return "Select a Arena";
                          else
                            return null;
                        },
                        selectedItem: _arena,
                        filterFn: (arena, filter) =>
                            this.searchArena(arena, filter),
                        searchBoxController: _arenaController,
                        hintText: 'Arena',
                        items: _arenas,
                        itemAsString: (arena) => arena.name,
                        onChanged: (arena) {
                          if (arena != null) {
                            setState(() {
                              _arena = arena;
                              _courts = arena.courts;
                              if (_courts.length == 1) {
                                _court = arena.courts[0];
                              }
                            });
                          } else {
                            setState(() {
                              _arena = null;
                              _courts = [];
                              _court = null;
                            });
                          }
                        },
                        showAddButton: true,
                        onAddPress: () async {
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddArenaScreen(),
                              ));
                          if (result != null) {
                            var arenas = await this.getArenas();
                            var activeArena = arenas
                                .firstWhere((arena) => arena.id == result);
                            setState(() {
                              _arena = activeArena;
                              _courts = activeArena.courts;
                              _court = activeArena.courts.length == 1
                                  ? activeArena.courts[0]
                                  : null;
                            });
                          }
                        },
                      ),
                      UIHelper.verticalSpaceSm,
                      SportsVisioDropDownWithAddButton<Court>(
                          showClearButton: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (Court? court) {
                            if (_arena != null && court == null)
                              return "Select a Court";
                            else
                              return null;
                          },
                          enabled: _arena != null,
                          selectedItem: _court,
                          filterFn: (court, filter) =>
                              this.searchCourts(court, filter),
                          searchBoxController: _courtController,
                          hintText: 'Court',
                          items: _courts,
                          itemAsString: (court) => court.name,
                          onChanged: (court) {
                            if (court != null) {
                              setState(() {
                                _court = court;
                              });
                            } else {
                              setState(() {
                                _court = null;
                              });
                            }
                          },
                          showAddButton: _arena != null,
                          onAddPress: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddArenaScreen(arena: _arena),
                                ));
                            if (result != null) {
                              var arenaId = result['arenaId'].toString();
                              var arenas = await this.getArenas();
                              var activeArena = arenas
                                  .firstWhere((arena) => arena.id == arenaId);
                              var activeCourt = activeArena.courts.firstWhere(
                                  (element) =>
                                      element.name ==
                                      result['courtName'].toString());
                              setState(() {
                                _arena = activeArena;
                                _courts = activeArena.courts;
                                _court = activeCourt;
                              });
                            }
                          }),
                      Spacer(),
                      PrimaryButton(
                          onPressed: handleAddGame, label: 'Add Game'),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ),
          ),
          _isLoading ? LoadingWidget() : Container(),
          customBnner(navigationService: _navigationService),
        ],
      ),
    );
  }

  bool searchTeam(teams.Team team, filter) {
    String name = team.name.toLowerCase();
    bool match =
        name.isNotEmpty ? name.contains(filter.toString().toLowerCase()) : true;
    return match;
  }

  bool searchArena(Arena arena, filter) {
    String name = arena.name.toLowerCase();
    bool match =
        name.isNotEmpty ? name.contains(filter.toString().toLowerCase()) : true;
    return match;
  }

  bool searchLeagues(leagues.League league, filter) {
    String name = league.name.toLowerCase();
    bool match =
        name.isNotEmpty ? name.contains(filter.toString().toLowerCase()) : true;
    return match;
  }

  bool searchCourts(Court court, filter) {
    String name = court.name.toLowerCase();
    bool match =
        name.isNotEmpty ? name.contains(filter.toString().toLowerCase()) : true;
    return match;
  }

  Future<List<Arena>> getArenas() async {
    var result =
        await Provider.of<ArenaViewModel>(context, listen: false).getArenas();

    return result;
  }

  Future<List<GameModel?>> getGames() async {
    var result =
        await Provider.of<GamesViewModel>(context, listen: false).getGamesNew();
    return result;
  }

  handleAddGame() async {
    if (_formKey.currentState!.validate()) {
      try {
        var createObject = {
          'description': '',
          'leagueId': _league!.id,
          'courtId': _court!.id,
          'startTime': _startDate!.millisecondsSinceEpoch,
          'endTime': _endTime!.millisecondsSinceEpoch,
          'season': 'Fall Season',
          'teams': [
            {'teamId': _teamA!.id, 'designation': 'TeamA', 'color': 'red'},
            {'teamId': _teamB!.id, 'designation': 'TeamB', 'color': 'blue'}
          ]
        };
        Provider.of<GamesViewModel>(context, listen: false)
            .createGameNew(createObject)
            .then((value) async {
          _toastService.showToast(context, 'Game created');
          Navigator.pop(context);
        });
      } catch (e) {
        _toastService.showToast(context, 'Unable to create game');
      }
    }
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true, minTime: DateTime.now(), onConfirm: (date) {
      _showStartTimePicker(date);
    });
  }

  void _showStartTimePicker(DateTime gameDate) {
    DatePicker.showTime12hPicker(context, showTitleActions: true,
        onConfirm: (gameStartTime) {
      _showEndTimePicker(gameDate, gameStartTime);
    });
  }

  void _showEndTimePicker(DateTime gameDate, DateTime gameStartTime) {
    DatePicker.showTime12hPicker(context, showTitleActions: true,
        onConfirm: (gameEndTime) {
      String formattedDate = DateFormat('MM.dd.yy').format(gameDate);
      String formattedStartTime = DateFormat('h:mmaa').format(gameStartTime);
      String formattedEndTime = DateFormat('h:mmaa').format(gameEndTime);
      _timeController.text =
          "$formattedDate @ $formattedStartTime - $formattedEndTime";
      _startTime = gameStartTime;
      _endTime = gameEndTime;
      _startDate = gameDate;
      print("$formattedDate @ $formattedStartTime - $formattedEndTime");
    });
  }
}
