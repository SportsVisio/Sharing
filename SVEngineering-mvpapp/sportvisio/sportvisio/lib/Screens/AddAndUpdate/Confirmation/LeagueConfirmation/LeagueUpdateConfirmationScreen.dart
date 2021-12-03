import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/ConfirmationModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/network/data_models/league_model.dart';

class LeagueUpdateConfirmationScreen extends StatelessWidget {
  final _navigationService = locator.get<NavigationHelper>();
  final LeaguesResponse leagueResponse;
  final LeaguesResponse leagueResponseNew;

  LeagueUpdateConfirmationScreen(
      {Key? key, required this.leagueResponse, required this.leagueResponseNew})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaguesViewModel>(
      builder: (context, viewModel, child) {
        String newLeagueName = leagueResponseNew.league;
        List<Team> teams = leagueResponseNew.teams;
        return ConfirmationModal(
          loading: viewModel.loading,
          title: "Is this correct?",
          subtitle: "You are about to update this league",
          content: Column(
            children: [
              UpdatedFields(title: "League", value: newLeagueName),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return UpdatedFields(
                          title: "Team ${index + 1}", value: teams[index].name);
                    },
                    itemCount: teams.length),
              ),
            ],
          ),
          onYes: () async {
            final List<Future<dynamic>> requests = [];
            var newLeague = leagueResponse.league != leagueResponseNew.league
                ? leagueResponseNew.league
                : null;
            //update teams
            var _newTeams = [];
            for (int i = 0; i < leagueResponse.teams.length; i++) {
              for (int j = 0; j < leagueResponseNew.teams.length; j++) {
                if (leagueResponse.teams[i].id ==
                    leagueResponseNew.teams[j].id) {
                  _newTeams.add([
                    leagueResponse.teams[i].name,
                    leagueResponseNew.teams[j].name
                  ]);
                }
              }
            }
            final payload = {
              "League": leagueResponse.league,
              "NewLeague": newLeague,
              "NewTeams": _newTeams
            };
            print(payload.toString());
            requests.add(viewModel.updateLeague(payload));
            //add teams to server
            for (int i = 0; i < leagueResponseNew.teamsAdd.length; i++) {
              final payload = {
                "League": leagueResponseNew.league,
                "Teams": {leagueResponseNew.teamsAdd[i].name: {}}
              };
              requests.add(viewModel.createTeam(payload));
            }
            // delete teams from server
            for (int i = 0; i < leagueResponseNew.teamsRemove.length; i++) {
              final payload = {
                "League": leagueResponseNew.league,
                "Team": leagueResponseNew.teamsRemove[i].name
              };
              requests.add(viewModel.deleteTeam(payload));
            }
            Future.wait(requests)
                .then((value) => _navigationService.pop(count: 2))
                .onError((error, stackTrace) {
              //todo showError
              _navigationService.pop(count: 2);
            });
          },
          onNo: () => _navigationService.pop(),
        );
      },
    );
  }
}
