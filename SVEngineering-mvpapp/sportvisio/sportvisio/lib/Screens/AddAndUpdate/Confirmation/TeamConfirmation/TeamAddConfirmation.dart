import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/ConfirmationModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';

class TeamAddConfirmation extends StatelessWidget {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaguesViewModel>(
      builder: (context, viewModel, child) {
        var payload = viewModel.payload;
        String leagueName = payload?['League'];
        String teamName = payload?['Team'];

        Map<String, dynamic> rousters = payload?['Players'];
        return ConfirmationModal(
            loading: viewModel.loading,
            title: "Is this correct?",
            subtitle: "You are about to Add this team",
            content: Column(
              children: [
                UpdatedFields(title: leagueName, value: leagueName),
                UpdatedFields(title: teamName, value: leagueName),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        print(rousters.toString());
                        var player = rousters.keys.elementAt(index);
                        var number = rousters.values.elementAt(index);
                        print(number['Number']);

                        return UpdatedFields(
                            title: "${number['Number'].toString()} ",
                            value: player);
                      },
                      itemCount: rousters.length),
                ),
              ],
            ),
            onYes: () async {
              final Map<String, Object> rousterPayload = {};

              for (int i = 0; i < rousters.length; i++) {
                rousterPayload[rousters.keys.elementAt(i)] =
                    rousters.values.elementAt(i);
              }

              final payload1 = {
                "League": leagueName,
                "Teams": {teamName: rousterPayload},
              };
              print(payload1.toString() + "???");
              final response = await viewModel.createTeam(payload1);
              if (response != null) {
                viewModel.getLeagues();
                Navigator.pop(context, teamName);
                Navigator.pop(context, teamName);
              } else {
                print("error during team creation");
                _navigationService.pop();
              }
            },
            onNo: () => _navigationService.pop());
      },
    );
  }
}
