import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/customSearchDropdown.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/data_models/arena_name_controller.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/ArenaModel.dart';

import 'AddArenaScreen.dart';

class UpdateArenaScreen extends StatefulWidget {
  final isAdd;
  final Arena arenaModel;

  UpdateArenaScreen({this.isAdd, required this.arenaModel});

  @override
  _UpdateArenaScreenState createState() => _UpdateArenaScreenState();
}

class _UpdateArenaScreenState extends State<UpdateArenaScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  static List<TextEditingController> courtControllers = [];
  final _formKey = GlobalKey<FormState>();
  final _arenaNameController = TextEditingController();
  final List<ArenaNameAndController> _courtsList = [];
  List<int> deletedCourtsIndexList = [];
  List<String> newAddCourtsList = [];
  late ArenaViewModel _viewModel;
  late Arena _arena;

  @override
  void initState() {
    super.initState();
    _arena = widget.arenaModel;
    _arenaNameController.text = widget.arenaModel.name;
    widget.arenaModel.courts.map((e) {
      _courtsList.add(ArenaNameAndController(
          controller: TextEditingController(text: e.name),
          id: e.id,
          name: e.name));
    }).toList();
    courtControllers.clear();
    widget.arenaModel.courts.forEach((element) {
      setState(() {
        courtControllers.add(TextEditingController(text: element.name));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ArenaViewModel>(builder: (context, viewModel, child) {
      _viewModel = viewModel;
      return Scaffold(
        backgroundColor:
            widget.isAdd ? HexColor("#DCF9E1") : HexColor("#BFEBFB"),
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "images/corner2.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 30,
                top: 70,
                child: Image.asset(
                  widget.isAdd ? "images/add.png" : "images/history.png",
                  width: 80,
                  height: 80,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          UIHelper.verticalSpaceMd,
                          Text(
                            'Update Arenas',
                            style: TextStyle(
                              fontFamily: 'regu',
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          customSearchDropdown(
                              _viewModel.arenas.map((e) => e.name).toList(),
                              (var selectedData) {
                                _arena = _viewModel.arenas.firstWhere(
                                    (element) => element.name == selectedData);
                                _courtsList.clear();
                                _arenaNameController.text = _arena.name;
                                _arena.courts.map((e) {
                                  _courtsList.add(ArenaNameAndController(
                                      controller:
                                          TextEditingController(text: e.name),
                                      id: e.id,
                                      name: e.name));
                                }).toList();
                                courtControllers.clear();
                                List<TextEditingController> controllers = [];
                                _arena.courts.forEach((element) {
                                  controllers.add(TextEditingController(
                                      text: element.name));
                                });
                                setState(() {
                                  _arena;
                                  _courtsList;
                                  courtControllers = controllers;
                                });
                              },
                              selectedItem: _arena.name,
                              isAdd: true,
                              onTapAdd: () async {
                                var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddArenaScreen(),
                                    ));
                                if (result != null) {
                                  _arena = _viewModel.arenas.firstWhere(
                                      (element) => element.id == result);
                                  _courtsList.clear();
                                  _arenaNameController.text = _arena.name;
                                  _arena.courts.map((e) {
                                    _courtsList.add(ArenaNameAndController(
                                        controller:
                                            TextEditingController(text: e.name),
                                        id: e.id,
                                        name: e.name));
                                  }).toList();
                                  courtControllers.clear();
                                  List<TextEditingController> controllers = [];
                                  _arena.courts.forEach((element) {
                                    controllers.add(TextEditingController(
                                        text: element.name));
                                  });
                                  setState(() {
                                    _arena;
                                    _courtsList;
                                    courtControllers = controllers;
                                  });
                                }
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          SportsVisioFormField(
                              hint: 'New Arena Name',
                              controller: _arenaNameController),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Update Courts',
                                style: TextStyle(
                                  fontFamily: 'regu',
                                  fontSize: 24.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      TextEditingController controller =
                                          new TextEditingController();
                                      courtControllers.add(controller);
                                      print(courtControllers.length.toString());
                                      //   friendsList.insert(0, "");
                                      _handleAddCourt();
                                    });
                                  },
                                  child: SvgPicture.string(
                                    '<svg viewBox="0.0 0.0 50.0 50.0" ><path transform="translate(-1.62, -1.62)" d="M 40.31591796875 24.20349502563477 L 29.04478454589844 24.20349502563477 L 29.04478454589844 12.93236541748047 C 29.04478454589844 11.6010103225708 27.95549392700195 10.51171875 26.62413787841797 10.51171875 C 25.29278564453125 10.51171875 24.20349502563477 11.6010103225708 24.20349502563477 12.93236541748047 L 24.20349502563477 24.20349502563477 L 12.93236541748047 24.20349502563477 C 11.6010103225708 24.20349502563477 10.51171875 25.11123657226562 10.51171875 26.62413787841797 C 10.51171875 28.13704299926758 11.64639759063721 29.04478454589844 12.93236541748047 29.04478454589844 C 14.21833324432373 29.04478454589844 24.20349502563477 29.04478454589844 24.20349502563477 29.04478454589844 C 24.20349502563477 29.04478454589844 24.20349502563477 38.87865829467773 24.20349502563477 40.31591796875 C 24.20349502563477 41.75317764282227 25.26252746582031 42.7365608215332 26.62413787841797 42.7365608215332 C 27.98575592041016 42.7365608215332 29.04478454589844 41.64727020263672 29.04478454589844 40.31591796875 L 29.04478454589844 29.04478454589844 L 40.31591796875 29.04478454589844 C 41.64727020263672 29.04478454589844 42.7365608215332 27.95549392700195 42.7365608215332 26.62413787841797 C 42.7365608215332 25.29278564453125 41.64727020263672 24.20349502563477 40.31591796875 24.20349502563477 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-3.38, -3.38)" d="M 28.37499809265137 6.740385055541992 C 34.15625 6.740385055541992 39.58893966674805 8.987980842590332 43.67548370361328 13.07451915740967 C 47.76202011108398 17.16106033325195 50.00961303710938 22.59374809265137 50.00961303710938 28.37499809265137 C 50.00961303710938 34.15625 47.76202011108398 39.58893966674805 43.67548370361328 43.67548370361328 C 39.58893966674805 47.76202011108398 34.15625 50.00961303710938 28.37499809265137 50.00961303710938 C 22.59374809265137 50.00961303710938 17.16106033325195 47.76202011108398 13.07451915740967 43.67548370361328 C 8.987980842590332 39.58893966674805 6.740385055541992 34.15625 6.740385055541992 28.37499809265137 C 6.740385055541992 22.59375190734863 8.987980842590332 17.16106033325195 13.07451915740967 13.07451915740967 C 17.16106033325195 8.987980842590332 22.59374809265137 6.740385055541992 28.37499809265137 6.740385055541992 M 28.37499809265137 3.375000238418579 C 14.56490325927734 3.375000238418579 3.375000238418579 14.56490325927734 3.375000238418579 28.37499809265137 C 3.375000238418579 42.18509674072266 14.56490325927734 53.375 28.37499809265137 53.375 C 42.18509674072266 53.375 53.375 42.18509674072266 53.375 28.37499809265137 C 53.375 14.56490135192871 42.18509674072266 3.375000238418579 28.37499809265137 3.375000238418579 L 28.37499809265137 3.375000238418579 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          renderCourt(),
                          UIHelper.verticalSpaceMd,
                          MaterialButton(
                            color: HexColor("#30BCED"),
                            minWidth: size.width,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                List<ArenaNameAndController> responseNewCourts =
                                    [];
                                List<ArenaNameAndController>
                                    responseUupdatedCourts = [];
                                List<ArenaNameAndController>
                                    responseDeletedCourts = [];
                                // we passed in courts but they have been removed from current stack so all all to delete list
                                if (_courtsList.length == 0) {
                                  _arena.courts.forEach((element) {
                                    responseDeletedCourts.add(
                                        ArenaNameAndController(
                                            name: element.name,
                                            id: element.id));
                                  });
                                } else {
                                  _arena.courts.forEach((court) {
                                    // court doesn't exist in current list so we add to delete list
                                    if (!_courtsList.any(
                                        (element) => element.id == court.id)) {
                                      responseDeletedCourts.add(
                                          ArenaNameAndController(
                                              id: court.id, name: court.name));
                                      // court exist and court name has been updated so add to update list
                                    } else if (_courtsList.any((element) =>
                                        element.id == court.id &&
                                        element.name!.toLowerCase() !=
                                            _courtsList
                                                .firstWhere(
                                                    (c) => c.id == court.id)
                                                .controller!
                                                .text
                                                .toLowerCase())) {
                                      responseUupdatedCourts.add(
                                          ArenaNameAndController(
                                              id: court.id,
                                              name: _courtsList
                                                  .firstWhere(
                                                      (c) => c.id == court.id)
                                                  .controller!
                                                  .text));
                                    }
                                  });
                                }
                                _courtsList.forEach((element) {
                                  if (element.id == null) {
                                    responseNewCourts.add(
                                        ArenaNameAndController(
                                            name: element.controller!.text));
                                  }
                                });
                                String newArenaName = _arenaNameController.text;
                                String arenaId = _arena.id;
                                var futures = <Future>[];
                                var arenaPayload = {'name': newArenaName};
                                try {
                                  _viewModel
                                      .updateArena(arenaId, arenaPayload)
                                      .then((value) async {
                                    if (value != null && value) {
                                      if (responseNewCourts.length > 0) {
                                        responseNewCourts.forEach((element) {
                                          var payload = {"name": element.name};
                                          futures.add(apiCallForCreateCourt(
                                              arenaId, payload));
                                        });
                                      }
                                      if (responseDeletedCourts.length > 0) {
                                        responseDeletedCourts
                                            .forEach((element) {
                                          futures.add(apiCallForDeleteCourt(
                                              element.id));
                                        });
                                      }
                                      if (responseUupdatedCourts.length > 0) {
                                        responseUupdatedCourts
                                            .forEach((element) {
                                          var payload = {"name": element.name};
                                          futures.add(apiCallForUpdateCourt(
                                              element.id, payload));
                                        });
                                      }
                                      await Future.wait(futures);
                                      viewModel.getArenas();
                                      _toastService.showToast(
                                          context, 'Updated successfully');
                                      _navigationService.pop();
                                    } else {
                                      _toastService.showToast(
                                          context, 'Arena not updated.');
                                      _navigationService.pop();
                                    }
                                  });
                                } catch (e) {
                                  _toastService.showToast(context,
                                      'Error occuring while trying to update.');
                                }
                              }
                            },
                            child: Text('Update',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                )),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            color: HexColor("#D21B1B"),
                            minWidth: size.width,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              _navigationService.navigateTo(
                                  AppRoutes.DELETE_ARENA_CONFIRMATION,
                                  arguments: _viewModel.arenas.firstWhere(
                                      (element) =>
                                          element.name == _arena.name));
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                height: 1.0,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceL,
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              customBnner(navigationService: _navigationService),
            ],
          ),
        ),
      );
    });
  }

  Future<void> apiCallForUpdateCourt(courtId, payload) async {
    final response = await _viewModel.updateCourt(courtId, payload);
    if (response != null) {
    } else {
      print("error updating court");
    }
  }

  Future<void> apiCallForDeleteCourt(courtId) async {
    final response = await _viewModel.deleteCourt(courtId);
    if (response != null) {
    } else {
      print("error deleting court");
    }
  }

  Future<void> apiCallForCreateCourt(arenaId, payload) async {
    final response = await _viewModel.createCourtNew(arenaId, payload);
    if (response != null) {
    } else {
      print("error creating court");
    }
  }

  ListView renderCourt() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: SportsVisioFormField(
                  hint: "Court ${index + 1}",
                  controller: _courtsList[index].controller,
                ),
              ),
              UIHelper.horizontalSpaceMd,
              Container(
                margin: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => _handleDeleteArena(index),
                  child: SvgPicture.string(
                    // Icon awesome-trash-alt
                    '<svg viewBox="0.0 0.0 31.5 36.0" ><path transform="translate(0.0, 0.0)" d="M 2.25 32.625 C 2.25 34.48896026611328 3.761039018630981 36 5.625 36 L 25.875 36 C 27.73896408081055 36 29.25000190734863 34.48896026611328 29.25000190734863 32.625 L 29.25 9 L 2.25 9 L 2.25 32.625 Z M 21.375 14.625 C 21.375 14.0036792755127 21.8786792755127 13.5 22.5 13.5 C 23.1213207244873 13.5 23.625 14.0036792755127 23.625 14.625 L 23.625 30.375 C 23.625 30.9963207244873 23.1213207244873 31.5 22.5 31.5 C 21.8786792755127 31.5 21.375 30.9963207244873 21.375 30.375 L 21.375 14.625 Z M 14.625 14.625 C 14.625 14.0036792755127 15.1286792755127 13.5 15.75 13.5 C 16.3713207244873 13.5 16.875 14.0036792755127 16.875 14.625 L 16.875 30.375 C 16.875 30.9963207244873 16.3713207244873 31.5 15.75 31.5 C 15.1286792755127 31.5 14.625 30.9963207244873 14.625 30.375 L 14.625 14.625 Z M 7.875 14.625 C 7.875 14.0036792755127 8.378679275512695 13.5 9 13.5 C 9.621320724487305 13.5 10.125 14.0036792755127 10.125 14.625 L 10.125 30.375 C 10.125 30.9963207244873 9.621320724487305 31.5 9 31.5 C 8.378679275512695 31.5 7.875 30.9963207244873 7.875 30.375 L 7.875 14.625 Z M 30.375 2.25 L 21.9375 2.25 L 21.27656173706055 0.9351562261581421 C 20.99098205566406 0.3617886304855347 20.4053955078125 -0.0004585981369018555 19.76484298706055 0 L 11.72812461853027 0 C 11.08877754211426 -0.002457857131958008 10.50429439544678 0.3607953786849976 10.22343730926514 0.9351558685302734 L 9.5625 2.25 L 1.125 2.25 C 0.503679633140564 2.25 -1.192092895507812e-07 2.753679752349854 0 3.375000238418579 L 0 5.625 C 0 6.246320247650146 0.5036796927452087 6.75 1.125 6.75 L 30.375 6.75 C 30.9963207244873 6.75 31.5 6.246320247650146 31.5 5.625 L 31.5 3.375 C 31.5 2.753679752349854 30.9963207244873 2.25 30.375 2.25 Z" fill="#e46a6a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: 32,
                    height: 36,
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => UIHelper.verticalSpaceSm,
        itemCount: _courtsList.length);
  }

  void _handleAddCourt() {
    setState(() {
      _courtsList
          .add(ArenaNameAndController(controller: TextEditingController()));
    });
  }

  void _handleDeleteArena(int index) {
    setState(() {
      _courtsList.removeAt(index);
      deletedCourtsIndexList.add(index);
    });
  }
}
