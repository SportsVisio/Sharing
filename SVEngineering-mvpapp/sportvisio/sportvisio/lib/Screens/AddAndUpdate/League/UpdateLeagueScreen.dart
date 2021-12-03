import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/background_icons/background_icon_update.dart';
import 'package:sportvisio/Widgets/buttons/primary_button.dart';
import 'package:sportvisio/Widgets/buttons/secondary_button.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/data_models/team_name_controller.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/network/data_models/league_model.dart';
import 'package:uuid/uuid.dart';

class UpdateLeagueScreen extends StatefulWidget {
  final LeaguesResponse leaguesResponse;

  const UpdateLeagueScreen({Key? key, required this.leaguesResponse})
      : super(key: key);

  @override
  _UpdateLeagueScreenState createState() =>
      _UpdateLeagueScreenState(leaguesResponse);
}

class _UpdateLeagueScreenState extends State<UpdateLeagueScreen> {
  final LeaguesResponse leaguesResponse;
  final _navigationService = locator.get<NavigationHelper>();
  final _formKey = GlobalKey<FormState>();
  final _leagueNameController = TextEditingController();
  final List<TeamNameAndController> _teamsList = [];
  final List<TeamNameAndController> _teamsListRemove = [];
  final List<TeamNameAndController> _teamsListAdd = [];

  _UpdateLeagueScreenState(this.leaguesResponse);

  late LeaguesViewModel leaguesViewModel;

  @override
  void initState() {
    super.initState();
    _leagueNameController.text = leaguesResponse.league;
    leaguesResponse.teams.forEach(
      (team) {
        _teamsList.add(
          TeamNameAndController(
              controller: TextEditingController(text: team.name), id: team.id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#BFEBFB"),
      body: Stack(
        children: [
          BackgroundIconUpdate(),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 0),
              height: size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leaguesSection(),
                    UIHelper.verticalSpace30,
                    teamsSection(),
                    Spacer(),
                    PrimaryButton(
                      onPressed: _handleUpdateLeague,
                      label: 'Update',
                    ),
                    UIHelper.verticalSpaceMd,
                    SecondaryButton(
                      onPressed: () => _handleUpdateLeague(shouldDelete: true),
                      label: 'Delete',
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          customBnner(navigationService: _navigationService),
        ],
      ),
    );
  }

  Widget leaguesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Update Leagues',
          style: heading3Style,
        ),
        UIHelper.verticalSpace30,
        SportsVisioFormField(
          hint: "League",
          controller: _leagueNameController,
        )
      ],
    );
  }

  Widget teamsSection() {
    return Consumer<LeaguesViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Update Teams', style: heading3Style),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: InkResponse(
                    child: SvgPicture.string(
                      // Icon ionic-ios-add-circle-outline
                      '<svg viewBox="0.0 0.0 50.0 50.0" ><path transform="translate(-1.62, -1.62)" d="M 40.31591796875 24.20349502563477 L 29.04478454589844 24.20349502563477 L 29.04478454589844 12.93236541748047 C 29.04478454589844 11.6010103225708 27.95549392700195 10.51171875 26.62413787841797 10.51171875 C 25.29278564453125 10.51171875 24.20349502563477 11.6010103225708 24.20349502563477 12.93236541748047 L 24.20349502563477 24.20349502563477 L 12.93236541748047 24.20349502563477 C 11.6010103225708 24.20349502563477 10.51171875 25.11123657226562 10.51171875 26.62413787841797 C 10.51171875 28.13704299926758 11.64639759063721 29.04478454589844 12.93236541748047 29.04478454589844 C 14.21833324432373 29.04478454589844 24.20349502563477 29.04478454589844 24.20349502563477 29.04478454589844 C 24.20349502563477 29.04478454589844 24.20349502563477 38.87865829467773 24.20349502563477 40.31591796875 C 24.20349502563477 41.75317764282227 25.26252746582031 42.7365608215332 26.62413787841797 42.7365608215332 C 27.98575592041016 42.7365608215332 29.04478454589844 41.64727020263672 29.04478454589844 40.31591796875 L 29.04478454589844 29.04478454589844 L 40.31591796875 29.04478454589844 C 41.64727020263672 29.04478454589844 42.7365608215332 27.95549392700195 42.7365608215332 26.62413787841797 C 42.7365608215332 25.29278564453125 41.64727020263672 24.20349502563477 40.31591796875 24.20349502563477 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-3.38, -3.38)" d="M 28.37499809265137 6.740385055541992 C 34.15625 6.740385055541992 39.58893966674805 8.987980842590332 43.67548370361328 13.07451915740967 C 47.76202011108398 17.16106033325195 50.00961303710938 22.59374809265137 50.00961303710938 28.37499809265137 C 50.00961303710938 34.15625 47.76202011108398 39.58893966674805 43.67548370361328 43.67548370361328 C 39.58893966674805 47.76202011108398 34.15625 50.00961303710938 28.37499809265137 50.00961303710938 C 22.59374809265137 50.00961303710938 17.16106033325195 47.76202011108398 13.07451915740967 43.67548370361328 C 8.987980842590332 39.58893966674805 6.740385055541992 34.15625 6.740385055541992 28.37499809265137 C 6.740385055541992 22.59375190734863 8.987980842590332 17.16106033325195 13.07451915740967 13.07451915740967 C 17.16106033325195 8.987980842590332 22.59374809265137 6.740385055541992 28.37499809265137 6.740385055541992 M 28.37499809265137 3.375000238418579 C 14.56490325927734 3.375000238418579 3.375000238418579 14.56490325927734 3.375000238418579 28.37499809265137 C 3.375000238418579 42.18509674072266 14.56490325927734 53.375 28.37499809265137 53.375 C 42.18509674072266 53.375 53.375 42.18509674072266 53.375 28.37499809265137 C 53.375 14.56490135192871 42.18509674072266 3.375000238418579 28.37499809265137 3.375000238418579 L 28.37499809265137 3.375000238418579 Z" fill="#30bced" stroke="#30bced" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      width: 40,
                      height: 40,
                    ),
                    onTap: _handleAddTeam,
                  ),
                )
              ],
            ),
            UIHelper.verticalSpaceMd,
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: SportsVisioFormField(
                          hint: "Team ${index + 1}",
                          controller: _teamsList[index].controller,
                        ),
                      ),
                      UIHelper.horizontalSpaceMd,
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () => _handleDeleteTeam(index, viewModel),
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
                itemCount: _teamsList.length),
          ],
        );
      },
    );
  }

  void _handleAddTeam() {
    var team = TeamNameAndController(
      controller: TextEditingController(),
      id: Uuid(),
    );
    _teamsListAdd.add(team);
    setState(() => _teamsList.add(team));
  }

  void _handleDeleteTeam(int index, LeaguesViewModel viewModel) {
    /* var payload = {
      "League": leaguesResponse.league,
      "Team": _teamsList[index].controller.value.text
    };*/
    var team = _teamsList.elementAt(index);
    _teamsListRemove.add(team);
    setState(() => _teamsList.remove(team));
    /* viewModel.deleteTeam(payload).then((_) {
      setState(() {
        _teamsList.removeAt(index);
      });
    });*/
  }

  void _handleUpdateLeague({shouldDelete = false}) async {
    if (_formKey.currentState!.validate()) {
      String newLeagueName = _leagueNameController.text;
      List<Team> newTeams = [];
      List<Team> newTeamsAdd = [];
      List<Team> newTeamsRemove = [];
      _teamsList.forEach((team) {
        newTeams
            .add(Team(name: team.controller.text, players: [], id: team.id));
      });
      _teamsListAdd.forEach((team) {
        newTeamsAdd
            .add(Team(name: team.controller.text, players: [], id: team.id));
      });
      _teamsListRemove.forEach((team) {
        newTeamsRemove
            .add(Team(name: team.controller.text, players: [], id: team.id));
      });

      LeaguesResponse newLeagueResponse = LeaguesResponse(
          league: newLeagueName,
          deleted: false,
          teams: newTeams,
          teamsAdd: newTeamsAdd,
          teamsRemove: newTeamsRemove);
      _navigationService.navigateTo(
        shouldDelete
            ? AppRoutes.DELETE_LEAGUE_CONFIRMATION
            : AppRoutes.UPDATE_LEAGUE_CONFIRMATION,
        arguments: [leaguesResponse, newLeagueResponse],
      );
    }
  }
}
