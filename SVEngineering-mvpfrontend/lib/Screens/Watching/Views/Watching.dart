import 'package:flutter/material.dart';
import 'package:mvp/Screens/Watching/ChannelTile.dart';
import 'package:mvp/Screens/Watching/WatchItem.dart';

import 'package:mvp/Screens/Watching/WatchingViewModel.dart';
import 'package:mvp/Screens/Watching1/Views/WatchingScreen.dart';
import 'package:mvp/Widgets/HeaderTile.dart';
import 'package:mvp/Widgets/MyCustomNav.dart';
import 'package:mvp/Widgets/nav_bar/StaticHeader.dart';
import 'package:provider/provider.dart';

class Watching extends StatefulWidget {
  const Watching({Key? key}) : super(key: key);

  @override
  _WatchingState createState() => _WatchingState();
}

class _WatchingState extends State<Watching> with TickerProviderStateMixin {
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
    return Consumer<WatchingViewModel>(
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
          bottomNavigationBar: MyCustomeNav1(1),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              StaticHeader(
                isFromDashBoard: false,
              ),
              InkWell(
                  onTap: () {
                    Provider.of<WatchingViewModel>(context, listen: false)
                        .changeWidget(key: "back");
                  },
                  child: HeaderTile('Watching')),
              ChannelTile(),
              !followingViewModel.isPlayerClick
                  ? WatchItem(_animationForAddButton)
                  : WatchingScreen(_animationForVSButton)
              //animationForVSButton: _animationForVSButton,

              //Expanded(child: WatchItem())
              //WatchItem()
            ]),
          ));
    });
  }
}
