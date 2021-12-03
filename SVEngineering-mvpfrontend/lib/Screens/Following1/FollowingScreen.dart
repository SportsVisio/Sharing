import 'package:flutter/material.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/Following/Views/AddVsPlayerView.dart';
import 'package:mvp/Screens/Following/Views/ChooseVsGameView.dart';
import 'package:mvp/Screens/Following/Views/ChooseVsotherGameView.dart';
import 'package:mvp/Screens/Following/Views/ClickPlayerView.dart';
import 'package:mvp/Screens/Following/Views/LifeLongResultView.dart';
import 'package:mvp/Screens/Following/Views/SpecificGameView.dart';
import 'package:mvp/Widgets/Headerview.dart';
import 'package:mvp/Widgets/MyCustomNav.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen>
    with TickerProviderStateMixin {
  bool isShowPlayerList = true;
  late AnimationController _animationControllerForAddButton;
  late AnimationController _animationControllerForVsButton;

  var _animationForAddButton;
  Animation<Offset>? _animationForVSButton;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationControllerForAddButton.dispose();
    _animationControllerForVsButton.dispose();
  }

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
      begin: Offset(3.0, 0.5),
      end: Offset(0, 0.5),
    ).animate(CurvedAnimation(
      parent: _animationControllerForVsButton,
      curve: Curves.easeInCubic,
    ));
    return Consumer<FollowingViewModel>(
        builder: (context, followingViewModel, child) {
      if (followingViewModel.isPlayerClick == true) {
        _animationControllerForAddButton.reset();
        _animationControllerForAddButton.forward();
      }
      if (followingViewModel.isAddVsPlayerClick == true) {
        _animationControllerForVsButton.reset();
        _animationControllerForVsButton.forward();
      }

      return Scaffold(
        bottomNavigationBar: MyCustomeNav1(0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  //followingViewModel.changeWidget(key: "list");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                },
                highlightColor: Colors.orange,
                child: HeaderView(
                  title: "Following",
                ),
              ),
              followingViewModel.isPlayerClick
                  ? ClickPlayerView(
                      animationForAddButton: _animationForAddButton,
                    )
                  : followingViewModel.isAddVsPlayerClick
                      ? AddVsPlayerView(
                          animationForVSButton: _animationForVSButton,
                        )
                      : followingViewModel.isTeamLifeLong
                          ? LifeLongResultView()
                          : followingViewModel.isSpecificGameSearch
                              ? SpecificGameSearchView()
                              : followingViewModel.isChooseVSGameCalender
                                  ? ChooseVsGameView()
                                  : followingViewModel.isSelectGameFromCalender
                                      ? ChooseVsOtherGameView()
                                      : Container(
                                          width: 200,
                                          height: 300,
                                          color: Colors.red,
                                        ),
            ],
          ),
        ),
      );
    });
  }
}
