import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/View/FollowingList.dart.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/Footer/Home.dart';
import 'package:mvp/Screens/Watching/Views/Watching.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCustomeNav1 extends StatefulWidget {
  int currentState;
  MyCustomeNav1(this.currentState);
  @override
  _MyCustomeNav1State createState() => _MyCustomeNav1State();
}

class _MyCustomeNav1State extends State<MyCustomeNav1> {
  bool isSpecialUser = false;
  bool isFollow = false;
  bool isWatch = false;
  bool isFavorite = false;
  bool isAchievement = false;
  bool isWhereDrop = false;

  bool allowNotification = false;
  bool allowLocation = false;

  bool isLearnClicked = false;
  int isClickedNum = 0;
  var pref;

  DateTime? currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPref();
    selectedState();

    //fcmCallback();
  }

  Future<void> getPref() async {
    pref = await SharedPreferences.getInstance();
    isSpecialUser = pref!.getBool('special_user');
  }

  void selectedState() {
    switch (widget.currentState) {
      case 0:
        setState(() {
          isFollow = true;
          isWatch = false;
          isFavorite = false;
          isAchievement = false;
          isWhereDrop = false;
        });
        break;
      case 1:
        setState(() {
          isFollow = false;
          isWatch = true;
          isFavorite = false;
          isAchievement = false;
          isWhereDrop = false;
        });
        break;
      case 2:
        setState(() {
          isFollow = false;
          isWatch = false;
          isFavorite = true;
          isAchievement = false;
          isWhereDrop = false;
        });
        break;
      case 3:
        setState(() {
          isFollow = false;
          isWatch = false;
          isFavorite = false;
          isAchievement = true;
          isWhereDrop = false;
        });
        break;
      case 3:
        setState(() {
          isFollow = false;
          isWatch = false;
          isFavorite = false;
          isAchievement = true;
          isWhereDrop = false;
        });
        break;
      case 4:
        setState(() {
          isFollow = false;
          isWatch = false;
          isFavorite = false;
          isAchievement = false;
          isWhereDrop = true;
        });
        break;
      default:
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
      } else {
        _onWillPop();
      }
      return false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: new BoxDecoration(
            color: Colors.black87,
            border:
                Border(top: BorderSide(width: 1, color: Colors.transparent))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                    onTap: () async {
                      setState(() {
                        widget.currentState = 0;
                        selectedState();
                      });
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => DashboardScreen(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                      /* if (pref.getInt("navAt") != 0) {
                        pref.setInt("navAt", 0);
                      } */
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color:
                              !isFollow ? Colors.black87 : MyColors.redColor),
                      child: Center(
                        child: AutoSizeText(
                          "Following",
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 16,
                          style: TextStyle(
                              fontFamily: 'regu',
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: InkWell(
                    onTap: () async {
                      setState(() {
                        widget.currentState = 1;
                        selectedState();
                      });

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Watching(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );

/*                       if (pref.getInt("navAt") != 1) {
                        pref.setInt("navAt", 1);
                      } */
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: !isWatch ? Colors.black87 : MyColors.redColor),
                      child: Center(
                        child: AutoSizeText(
                          "Watch",
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 16,
                          style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.currentState = 2;
                        selectedState();
                      });
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => FollowingList(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                      /* if (pref.getInt("navAt") != 2) {
                        pref.setInt("navAt", 2);
                      } */
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color:
                              !isFavorite ? Colors.black87 : MyColors.redColor),
                      child: Center(
                        child: AutoSizeText(
                          "Favorites",
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 16,
                          style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.currentState = 2;
                        selectedState();
                      });
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Home(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                      /* if (pref.getInt("navAt") != 3) {
                        pref.setInt("navAt", 3);
                      } */
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: !isAchievement
                              ? Colors.black87
                              : MyColors.redColor),
                      child: Center(
                        child: AutoSizeText(
                          "Achievements",
                          maxLines: 1,
                          minFontSize: 10,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'regu',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
