import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/CustomTextField.dart';
import 'package:sportvisio/Widgets/background_icons/background_icon_add.dart';
import 'package:sportvisio/Widgets/customSearchDropdown.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/data_models/team_name_controller.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:uuid/uuid.dart';

class AddTeamScreen extends StatefulWidget {
  var leagueName;
  dynamic teamName;
  AddTeamScreen({this.leagueName, this.teamName});
  @override
  _AddTeamScreenState createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  late LeaguesViewModel _viewModel;
  var selectedLeague = '';
  final List<TeamNameAndController> _teamsList = [];
  final List<TeamNameAndController> _teamsListNumbers = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController teamController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedLeague = widget.leagueName != null ? widget.leagueName : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<LeaguesViewModel>(builder: (context, viewModel, child) {
      _viewModel = viewModel;
      return Scaffold(
        backgroundColor: HexColor("#DCF9E1"),
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
              BackgroundIconAdd(),
              Form(
                key: _formKey,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          UIHelper.horizontalSpaceMd,
                          Text(
                            'Add team and Roster',
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
                            _viewModel.leaguesResponses
                                .map((e) => e.league)
                                .toList(),
                            (var selectedData) {
                              setState(() {
                                selectedLeague = selectedData!;
                              });
                              print(selectedLeague);
                            },
                            selectedItem: selectedLeague,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SportsVisioFormField(
                                  hint: "Team",
                                  controller: teamController,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Update Roster',
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
                                    _handleAddTeam();
                                  },
                                  child: SvgPicture.string(
                                    // Icon ionic-ios-add-circle-outline
                                    '<svg viewBox="0.0 0.0 50.0 50.0" ><path transform="translate(-1.62, -1.62)" d="M 40.31591796875 24.20349502563477 L 29.04478454589844 24.20349502563477 L 29.04478454589844 12.93236541748047 C 29.04478454589844 11.6010103225708 27.95549392700195 10.51171875 26.62413787841797 10.51171875 C 25.29278564453125 10.51171875 24.20349502563477 11.6010103225708 24.20349502563477 12.93236541748047 L 24.20349502563477 24.20349502563477 L 12.93236541748047 24.20349502563477 C 11.6010103225708 24.20349502563477 10.51171875 25.11123657226562 10.51171875 26.62413787841797 C 10.51171875 28.13704299926758 11.64639759063721 29.04478454589844 12.93236541748047 29.04478454589844 C 14.21833324432373 29.04478454589844 24.20349502563477 29.04478454589844 24.20349502563477 29.04478454589844 C 24.20349502563477 29.04478454589844 24.20349502563477 38.87865829467773 24.20349502563477 40.31591796875 C 24.20349502563477 41.75317764282227 25.26252746582031 42.7365608215332 26.62413787841797 42.7365608215332 C 27.98575592041016 42.7365608215332 29.04478454589844 41.64727020263672 29.04478454589844 40.31591796875 L 29.04478454589844 29.04478454589844 L 40.31591796875 29.04478454589844 C 41.64727020263672 29.04478454589844 42.7365608215332 27.95549392700195 42.7365608215332 26.62413787841797 C 42.7365608215332 25.29278564453125 41.64727020263672 24.20349502563477 40.31591796875 24.20349502563477 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-3.38, -3.38)" d="M 28.37499809265137 6.740385055541992 C 34.15625 6.740385055541992 39.58893966674805 8.987980842590332 43.67548370361328 13.07451915740967 C 47.76202011108398 17.16106033325195 50.00961303710938 22.59374809265137 50.00961303710938 28.37499809265137 C 50.00961303710938 34.15625 47.76202011108398 39.58893966674805 43.67548370361328 43.67548370361328 C 39.58893966674805 47.76202011108398 34.15625 50.00961303710938 28.37499809265137 50.00961303710938 C 22.59374809265137 50.00961303710938 17.16106033325195 47.76202011108398 13.07451915740967 43.67548370361328 C 8.987980842590332 39.58893966674805 6.740385055541992 34.15625 6.740385055541992 28.37499809265137 C 6.740385055541992 22.59375190734863 8.987980842590332 17.16106033325195 13.07451915740967 13.07451915740967 C 17.16106033325195 8.987980842590332 22.59374809265137 6.740385055541992 28.37499809265137 6.740385055541992 M 28.37499809265137 3.375000238418579 C 14.56490325927734 3.375000238418579 3.375000238418579 14.56490325927734 3.375000238418579 28.37499809265137 C 3.375000238418579 42.18509674072266 14.56490325927734 53.375 28.37499809265137 53.375 C 42.18509674072266 53.375 53.375 42.18509674072266 53.375 28.37499809265137 C 53.375 14.56490135192871 42.18509674072266 3.375000238418579 28.37499809265137 3.375000238418579 L 28.37499809265137 3.375000238418579 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Center(
                                        child: SportsVisioFormField(
                                          hint: "${index + 1}",
                                          keyboardType: TextInputType.number,
                                          controller: _teamsListNumbers[index]
                                              .controller,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SportsVisioFormField(
                                        hint: "Roster ${index + 1}",
                                        controller:
                                            _teamsList[index].controller,
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceMd,
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () => _handleDeleteTeam(index),
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
                              separatorBuilder: (_, __) =>
                                  UIHelper.verticalSpaceSm,
                              itemCount: _teamsList.length),
                          UIHelper.horizontalSpaceMd,
                          MaterialButton(
                            color: HexColor("#10B430"),
                            minWidth: size.width,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              // _navigationService.navigateTo(
                              //     AppRoutes.UPDATE_TEAM_CONFIRMATION);
                              _handleAddTeamWithPlayers();
                            },
                            child: Text('Add Game',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                )),
                          ),
                          SizedBox(height: 10),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Row customDeleteWidget({var id, var name, var onDelete}) {
    return Row(
      children: [
        Container(
          width: 41.0,
          height: 41.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              id,
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 18.0,
                color: const Color(0xFFD5D5D5),
                height: 1.11,
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
          height: 41.0,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'regu',
                  fontSize: 18.0,
                  color: const Color(0xFFD5D5D5),
                  height: 1.11,
                ),
              ),
            ),
          ),
        )),
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
        )
      ],
    );
  }

  void _handleAddTeam() {
    setState(() {
      _teamsList.add(TeamNameAndController(
          controller: TextEditingController(), id: Uuid()));
      _teamsListNumbers.add(TeamNameAndController(
          controller: TextEditingController(), id: Uuid()));
    });
  }

  void _handleDeleteTeam(int index) {
    setState(() {
      _teamsList.removeAt(index);
      _teamsListNumbers.removeAt(index);
    });
  }

  void _handleAddTeamWithPlayers() async {
    final Map<String, Object> rousterPayload = {};
    if (_formKey.currentState!.validate()) {
      String teamName = teamController.text;
      for (int i = 0; i < _teamsList.length; i++) {
        rousterPayload[_teamsList[i].controller.text] = {
          "Number": _teamsListNumbers[i].controller.text
        };
      }

      final payload = {
        "League": selectedLeague,
        "Team": teamName,
        "Players": rousterPayload
      };
      print(payload.toString());
      final _viewModel = Provider.of<LeaguesViewModel>(context, listen: false);
      _viewModel.setPayload(payload);
      _navigationService.navigateTo(AppRoutes.ADD_TEAM_CONFIRMATION);
    }
  }
}
