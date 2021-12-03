import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/WarningModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';

class TeamDeleteConfirmationScreen extends StatelessWidget {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaguesViewModel>(builder: (context, viewModel, child) {
      var payload = viewModel.payload;
      String leagueName = payload?['League'];
      String teamName = payload?['Team'];

      Map<String, dynamic> rousters = payload?['Players'];
      return WarningModal(
          loading: viewModel.loading,
          title: "Is this correct?",
          subtitle: "You are about to delete this team",
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
            final response = await viewModel.deleteTeam(payload);
            if (response != null) {
              _navigationService.pop(count: 2);
            } else {
              print("error during team deleting");
              _navigationService.pop();
            }
          },
          onNo: () => _navigationService.pop());
    });
  }
}
