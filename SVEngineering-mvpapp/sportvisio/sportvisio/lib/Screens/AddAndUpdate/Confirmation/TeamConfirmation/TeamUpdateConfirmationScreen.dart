import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/ConfirmationModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/network/data_models/team_updateModel.dart';

class TeamUpdateConfirmationScreen extends StatelessWidget {
  TeamUpdateResponse teamUpdateResponse;
  TeamUpdateConfirmationScreen(this.teamUpdateResponse);

  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaguesViewModel>(builder: (context, viewModel, child) {
      return ConfirmationModal(
          loading: viewModel.loading,
          title: "Is this correct?",
          subtitle: "You are about to update this team",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamUpdateResponse.newLeague,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                teamUpdateResponse.newTeam,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  itemCount: teamUpdateResponse.newlayers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UpdatedFields(
                        title: (int.parse(
                                    teamUpdateResponse.playersNumbers[index])) >
                                9
                            ? (teamUpdateResponse.playersNumbers[index])
                                    .toString() +
                                "   ${teamUpdateResponse.newlayers[index]}"
                            : "0" +
                                (teamUpdateResponse.playersNumbers[index])
                                    .toString() +
                                "   ${teamUpdateResponse.newlayers[index]}",
                        value: "");
                  }),
            ],
          ),
          onYes: () async {
            // var payloadLeague = {
            //   "League": teamUpdateResponse.oldLeague,
            //   "NewLeague": teamUpdateResponse.newLeague
            // };

            // final response = await viewModel.updateLeague(payloadLeague);
            // if (response != null) {
            //   if (teamUpdateResponse.oldPlayers.length > 0) {
            //     var payloadRouster = {
            //       "League": teamUpdateResponse.newLeague,
            //       "Team": teamUpdateResponse.newTeam,
            //       "Player": teamUpdateResponse.oldPlayers[0],
            //       "NewPlayer": {
            //         teamUpdateResponse.newlayers[0]: {
            //           "Number": teamUpdateResponse.playersNumbers[0]
            //         }
            //       }
            //     };

            //     final response = await viewModel.updateLeague(payloadRouster);
            //     if (response != null) {
            //     } else {
            //       print("error during league creation");
            //       _navigationService.pop();
            //     }
            //   }
            //   _navigationService.pop(count: 2);
            // } else {
            //   print("error during league creation");
            //   _navigationService.pop();
            // }
            var payload = {
              "League": teamUpdateResponse.oldLeague,
              "Team": teamUpdateResponse.newTeam,
              "NewLeague":
                  teamUpdateResponse.newLeague != teamUpdateResponse.oldLeague
                      ? teamUpdateResponse.newLeague
                      : null,
              "NewTeam":
                  teamUpdateResponse.newTeam != teamUpdateResponse.newTeam
                      ? teamUpdateResponse.newTeam
                      : null,
              "NewPlayers": teamUpdateResponse.newlayers.map((e) {
                var index = teamUpdateResponse.newlayers
                    .indexWhere((element) => element == e);
                return [
                  e,
                  {
                    e: {
                      "Number":
                          teamUpdateResponse.playersNumbers[index].toString()
                    }
                  }
                ];
              }).toList()
            };
            print(payload);
            final response = await viewModel.updateLeagueTeam(payload);

            if (response != null) {
              await teamUpdateResponse.deletedPlayers.map((e) async {
                var deletedPayload = {
                  "League": teamUpdateResponse.oldLeague,
                  "Team": teamUpdateResponse.newTeam,
                  "Player": e
                };
                print(deletedPayload);
                final response = await viewModel.deletePlayer(deletedPayload);
              }).toList();
              if (response != null) {
                viewModel.getLeagues();
                _navigationService.pop(count: 2);
              }
            } else {
              print("error during league creation");
              _navigationService.pop();
            }
          },
          onNo: () => _navigationService.pop());
    });
  }
}
