import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/WarningModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/network/data_models/league_model.dart';

class LeagueDeleteConfirmationScreen extends StatelessWidget {
  final _navigationService = locator.get<NavigationHelper>();
  final LeaguesResponse leaguesResponse;

  LeagueDeleteConfirmationScreen({Key? key, required this.leaguesResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaguesViewModel>(
      builder: (context, viewModel, child) {
        String leagueName = leaguesResponse.league;
        List<Team> teams = leaguesResponse.teams;
        return WarningModal(
          loading: viewModel.loading,
          title: "Is this correct?",
          subtitle: "You are about to delete this league",
          content: Column(
            children: [
              UpdatedFields(title: "League", value: leagueName),
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
            final response =
                await viewModel.deleteLeague({"League": leagueName});
            if (response != null) {
              _navigationService.pop(count: 2);
            } else {
              print("error during league creation");
              _navigationService.pop();
            }
          },
          onNo: () => _navigationService.pop(),
        );
      },
    );
  }
}
