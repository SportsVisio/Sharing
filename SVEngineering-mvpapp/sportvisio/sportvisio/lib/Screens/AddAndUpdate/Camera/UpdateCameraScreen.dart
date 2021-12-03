import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/Screens/AddAndUpdate/Arena/AddArenaScreen.dart';
import 'package:sportvisio/Widgets/background_icons/background_icon_add.dart';
import 'package:sportvisio/Widgets/buttons/primary_button.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/sportsvisio_drop_down_with_add_button.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/ArenaModel.dart';
import 'package:sportvisio/network/data_models/Court.dart';

class UpdateCameraScreen extends StatefulWidget {
  final String? arenaId;

  UpdateCameraScreen({String? this.arenaId, Key? key}) : super(key: key);

  @override
  _UpdateCameraScreenState createState() => _UpdateCameraScreenState();
}

class _UpdateCameraScreenState extends State<UpdateCameraScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _formKey = GlobalKey<FormState>();
  Arena? _arena;
  List<Court>? _courts = [];
  Court? _court;
  String? _side;
  var token;

  @override
  void initState() {
    super.initState();
    this.setToken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor("#BFEBFB"),
      body: Stack(
        children: [
          BackgroundIconAdd(),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: size.height,
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'Update Camera',
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      UIHelper.verticalSpace30,
                      SportsVisioDropDownWithAddButton<Arena>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (Arena? arena) {
                          if (arena == null)
                            return "Select an Arena";
                          else
                            return null;
                        },
                        selectedItem: _arena,
                        filterFn: (arena, filter) =>
                            this.searchArena(arena, filter),
                        searchBoxController: TextEditingController(),
                        hintText: 'Arena',
                        onFind: (filter) async {
                          var arenas = this.getArenas(filter);
                          return arenas;
                        },
                        itemAsString: (arena) => arena.name,
                        onChanged: (arena) {
                          if (arena != null) {
                            setState(() {
                              _arena = arena;
                              _courts = arena.courts;
                              _court = arena.courts.length == 1
                                  ? arena.courts[0]
                                  : null;
                            });
                          } else {
                            setState(() {
                              _arena = null;
                              _courts = [];
                              _court = null;
                              _side = null;
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
                            // get the list of arenas and populate dropdown
                            var arenas = await this.getArenas('');
                            // set the selected arena based on arena id
                            var activeArena = arenas
                                .firstWhere((arena) => arena.id == result.id);
                            setState(() {
                              _side = null;
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (Court? court) {
                            if (_arena != null && court == null)
                              return "Select an Court";
                            else
                              return null;
                          },
                          enabled: _arena != null,
                          selectedItem: _court,
                          filterFn: (court, filter) =>
                              this.searchCourts(court, filter),
                          searchBoxController: TextEditingController(),
                          hintText: 'Courts',
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
                                _side = null;
                              });
                            }
                          },
                          showAddButton: _arena != null,
                          onAddPress: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddArenaScreen(),
                                ));
                            if (result != null) {}
                          }),
                      UIHelper.verticalSpaceSm,
                      SportsVisioDropDownWithAddButton<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? side) {
                          if (_arena != null && side == null)
                            return "Select an side of court";
                          else
                            return null;
                        },
                        enabled: _court != null,
                        showSearchBox: false,
                        selectedItem: _side,
                        searchBoxController: TextEditingController(),
                        hintText: 'Side of Court',
                        items: ['Left', 'Center', 'Right'],
                        onChanged: (side) {
                          if (side != null) {
                            setState(() {
                              _side = side;
                            });
                          } else {
                            setState(() {
                              _side = null;
                            });
                          }
                        },
                        showAddButton: false,
                        onAddPress: () async {},
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      PrimaryButton(
                          onPressed: handleUpdateGame,
                          label: 'Update',
                          color: '#30BCED'),
                      Spacer(),
                    ],
                  ))),
          customBnner(navigationService: _navigationService),
        ],
      ),
    );
  }

  void setToken() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
    });
  }

  Future<List<Arena>> getArenas(filter) async {
    var result =
        await Provider.of<ArenaViewModel>(context, listen: false).getArenas();

    return result;
  }

  bool searchArena(Arena arena, filter) {
    String name = arena.name.toLowerCase();
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

  handleUpdateGame() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _arena);
    }
  }
}
