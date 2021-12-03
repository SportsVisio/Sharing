import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/Widgets/modals/WarningModal.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/network/data_models/Arena.dart';
import 'package:sportvisio/network/data_models/Court.dart';

class ArenaDeleteConfirmationScreen extends StatefulWidget {
  final Arena arenaModel;

  ArenaDeleteConfirmationScreen({required this.arenaModel});

  @override
  _ArenaDeleteConfirmationScreenState createState() =>
      _ArenaDeleteConfirmationScreenState();
}

class _ArenaDeleteConfirmationScreenState
    extends State<ArenaDeleteConfirmationScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  late ArenaViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<ArenaViewModel>(builder: (context, viewModel, child) {
      _viewModel = viewModel;
      return WarningModal(
        loading: _viewModel.loading,
        title: 'Is this correct?',
        subtitle: 'You are about to delete this arena',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            updatedFields(
                title: "Arena Name:  " + widget.arenaModel.name, value: ""),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Courts",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            for (Court court in widget.arenaModel.courts)
              updatedFields(title: court.name, value: ""),
          ],
        ),
        onYes: () async {
          final response = await viewModel.deleteArena(widget.arenaModel.id);
          if (response != null) {
            _toastService.showToast(context, 'Arena successfully deleted');
            viewModel.getArenas();
            _navigationService.pop(count: 2);
          } else {
            print("error during league creation");
            _navigationService.pop();
          }
        },
        onNo: () => _navigationService.pop(),
      );
    });
  }

  Row updatedFields({var title, var value}) {
    return Row(
      children: [
        Container(
          child: Text(title, textAlign: TextAlign.left, style: bodyStyle),
        ),
      ],
    );
  }
}
