import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mvp/Screens/AddFollowing.dart/View/FollowingList.dart.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/Following1/FollowingScreen.dart';
import 'package:mvp/Screens/Footer/Home.dart';
import 'package:mvp/Screens/Watching/Views/Watching.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PersistNavBar extends StatefulWidget {
  @override
  _PersistNavBarState createState() => _PersistNavBarState();
}

class _PersistNavBarState extends State<PersistNavBar> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  late BuildContext testContext;
  int _currentIndex = 0;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [DashboardScreen(), Watching(), FollowingList(), Home()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          MdiIcons.mapSearchOutline,
          size: 0,
        ),
        title: "Following",
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white,
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.yellow,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => FollowingScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          child: Icon(
            MdiIcons.mapSearchOutline,
            size: 30,
          ),
        ),
        title: "Following",
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white,
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.yellow,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => FollowingScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          child: Icon(
            MdiIcons.mapSearchOutline,
            size: 30,
          ),
        ),
        title: "Following",
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white,
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.yellow,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => FollowingScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          child: Icon(
            MdiIcons.mapSearchOutline,
            size: 30,
          ),
        ),
        title: "Following",
        activeColorSecondary: Colors.white,
        inactiveColorSecondary: Colors.white,
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.yellow,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => FollowingScreen(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop(BuildContext context) async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
      } else {
        _onWillPop();
      }
      return false;
    }

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,

        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,

        backgroundColor: Colors.black87,
        handleAndroidBackButtonPress: true,

        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        //  onWillPop: onWillPop,
        selectedTabScreenContext: (context) {
          testContext = context!;
        },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.5, 0))
            ],
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.circular(0.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 1),
        ),
        navBarStyle:
            NavBarStyle.style10, // Choose the nav bar style with this property
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}

// ----------------------------------------- Custom Style ----------------------------------------- //
