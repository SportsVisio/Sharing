import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/ConfirmationModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';

class LeagueAddConfirmationScreen extends StatelessWidget {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaguesViewModel>(
      builder: (context, viewModel, child) {
        var payload = viewModel.payload;
        String leagueName = payload?['League'];
        Map<String, dynamic> teams = payload?['Teams'];
        return ConfirmationModal(
            loading: viewModel.loading,
            title: "Is this correct?",
            subtitle: "You are about to add this league",
            content: Column(
              children: [
                UpdatedFields(title: "League", value: leagueName),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        var team = teams.keys.elementAt(index);
                        return UpdatedFields(
                            title: "Team ${index + 1}", value: team);
                      },
                      itemCount: teams.length),
                ),
              ],
            ),
            onYes: () async {
              final response = await viewModel.createLeague(payload);
              if (response != null) {
                //_navigationService.pop(count: 2);
                Navigator.pop(context, payload);
                Navigator.pop(context, payload);
              } else {
                print("error during league creation");
                _navigationService.pop();
              }
            },
            onNo: () => _navigationService.pop());
      },
    );
  }
}
