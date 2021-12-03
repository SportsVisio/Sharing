import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/Following/playerListView.dart';
import 'package:mvp/Widgets/ExpandedTrailling.dart';
import 'package:mvp/core/view_models/ExpandedViewModel.dart';
import 'package:provider/provider.dart';

class FollowingExpanded extends StatefulWidget {
  const FollowingExpanded({Key? key}) : super(key: key);

  @override
  _FollowingExpandedState createState() => _FollowingExpandedState();
}

class _FollowingExpandedState extends State<FollowingExpanded>
    with TickerProviderStateMixin {
  bool isShowPlayerList = true;
  late AnimationController _animationControllerForAddButton;
  late AnimationController _animationControllerForVsButton;
  var _animationForAddButton;
  var _animationForVSButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _animationControllerForAddButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationControllerForVsButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animationForAddButton = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationControllerForAddButton, curve: Curves.linear));
    _animationForVSButton = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationControllerForVsButton,
      curve: Curves.easeInCubic,
    ));
    return Consumer<ExpandedViewModel>(builder: (context, viewModel, child) {
      return ListTileTheme(
        minVerticalPadding: 0,
        tileColor: HexColor("#DB0303"),
        selectedColor: Colors.white,
        textColor: Colors.white,
        child: ExpansionTile(
          initiallyExpanded: viewModel.isFollowExpanded,
          maintainState: viewModel.isFollowExpanded,
          key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Following',
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 16,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          title: Container(),
          // trailing: expandedTrailling(),
          onExpansionChanged: (value) {
            Provider.of<FollowingViewModel>(context, listen: false)
                .changeWidget(key: "list");
            viewModel.changeExpandState('following', value);
          },
          children: [
            SizedBox(
              height: 10,
            ),
            Consumer<FollowingViewModel>(
                builder: (context, followingViewModel, child) {
              if (followingViewModel.isPlayerClick == true) {
                _animationControllerForAddButton.reset();
                _animationControllerForAddButton.forward();
              }

              if (followingViewModel.isAddVsPlayerClick == true) {
                _animationControllerForVsButton.reset();
                _animationControllerForVsButton.forward();
              }

              return SingleChildScrollView(
                  child:
                      // followingViewModel.isShowList
                      //?
                      playerListView(size: size)
                  // : followingViewModel.isPlayerClick
                  //     ? ClickPlayerView(
                  //         animationForAddButton: _animationForAddButton,
                  //       )
                  // : Container(
                  //     width: 200,
                  //     height: 300,
                  //     color: Colors.red,
                  //   ),
                  );
            }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    });
  }
}
