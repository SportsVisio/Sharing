import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/UpdatedFields.dart';
import 'package:sportvisio/Widgets/modals/WarningModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/view_models/games_viewModel.dart';
import 'package:sportvisio/network/data_models/GameModelNew.dart';

class GameDeleteConfirmationScreen extends StatelessWidget {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  final GameModel gameModel;

  GameDeleteConfirmationScreen({Key? key, required this.gameModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesViewModel>(
      builder: (context, viewModel, child) {
        return WarningModal(
            title: "Is this correct?",
            subtitle: "You are about to delete this game",
            loading: viewModel.loading,
            content: Column(
              children: [
                UpdatedFields(
                    title:
                        '${gameModel.formattedStartDate} @ ${gameModel.formattedStartTime} - ${gameModel.formattedEndTime}',
                    value: ""),
                UpdatedFields(
                    title:
                        '@ ${gameModel.court != null ? gameModel.court!.name : ''}',
                    value: ""),
                UpdatedFields(title: gameModel.league.name, value: ""),
                UpdatedFields(
                    title:
                        '${gameModel.teamGameAssn[0].team.name} vs ${gameModel.teamGameAssn[1].team.name}',
                    value: "")
              ],
            ),
            onYes: () async {
              try {
                await viewModel.deleteGameNew(gameModel.id);
                await viewModel.getGamesNew();
                _toastService.showToast(context, 'Game deleted');
                _navigationService.pop(count: 2);
              } catch (e) {
                _toastService.showToast(context, 'Unable to delete game');
                _navigationService.pop();
              }
            },
            onNo: () => _navigationService.pop());
      },
    );
  }
}
