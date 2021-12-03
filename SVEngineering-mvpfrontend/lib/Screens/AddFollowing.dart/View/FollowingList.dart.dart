import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/FollowingGrid.dart';
import 'package:mvp/Screens/AddFollowing.dart/Models/FollowingModel.dart';
import 'package:mvp/Screens/AddFollowing.dart/View/AddFollowingScreen.dart';
import 'package:mvp/Widgets/HeaderTile.dart';
import 'package:mvp/Widgets/MyCustomNav.dart';
import 'package:mvp/Widgets/nav_bar/StaticHeader.dart';
import 'package:provider/provider.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({Key? key}) : super(key: key);

  @override
  _FollowingListState createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList>
    with TickerProviderStateMixin {
  bool isShowPlayerList = true;
  late AnimationController _animationControllerForAddButton;
  late AnimationController _animationControllerForVsButton;

  var _animationForAddButton;
  Animation<Offset>? _animationForVSButton;
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
      begin: const Offset(1.0, 0.0),
      end: const Offset(-3.3, 0),
    ).animate(CurvedAnimation(
      parent: _animationControllerForVsButton,
      curve: Curves.easeInCubic,
    ));
    return Consumer<FollowingModel>(
        builder: (context, followingViewModel, child) {
      if (followingViewModel.isPlayerClick == true) {
        _animationControllerForAddButton.reset();
        _animationControllerForAddButton.forward();
      }
      if (followingViewModel.isAddVsPlayerClick == true) {
        _animationControllerForVsButton.reset();
        _animationControllerForVsButton.forward();
      }
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        bottomNavigationBar: MyCustomeNav1(2),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            StaticHeader(isFromDashBoard: false),
            InkWell(
                onTap: () {
                  followingViewModel.changeWidget(key: "back");
                },
                child: HeaderTile('Following')),
            followingViewModel.isPlayerSelected
                ? FollowingGrid(
                    size: size,
                  )
                : AddFollowingScreen(size: size)
          ]),
        ),
      );
    });
  }
}
