import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/View/FollowingList.dart.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/Footer/Home.dart';
import 'package:mvp/Screens/Watching/Views/Watching.dart';
import 'package:mvp/core/constants/Colors.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int index = 0;
  Color button1 = Colors.black;
  Color button2 = Colors.black;
  Color button3 = Colors.black;
  Color button4 = Colors.black;
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_getStackedWidget(), _getNavigationButton()],
      ),
    );
  }

  Widget _getStackedWidget() {
    return Expanded(
      child: IndexedStack(
        index: index,
        children: [DashboardScreen(), Watching(), FollowingList(), Home()],
      ),
    );
  }

  Widget _getNavigationButton() {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: button1),
              onPressed: () {
                setState(() {
                  index = 0;
                  button1 = MyColors.redColor;
                  button2 = Colors.black;
                  button3 = Colors.black;
                  button4 = Colors.black;
                });
              },
              child: Text('Following')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: button2),
              onPressed: () {
                setState(() {
                  index = 1;
                  button2 = MyColors.redColor;
                  button1 = Colors.black;
                  button3 = Colors.black;
                  button4 = Colors.black;
                });
              },
              child: Text('Watch')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: button3),
              onPressed: () {
                setState(() {
                  index = 2;
                  button1 = Colors.black;
                  button2 = Colors.black;
                  button3 = MyColors.redColor;
                  button4 = Colors.black;
                });
              },
              child: Text('Favorites')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: button4),
              onPressed: () {
                setState(() {
                  index = 3;
                  button1 = Colors.black;
                  button2 = Colors.black;
                  button3 = Colors.black;
                  button4 = MyColors.redColor;
                });
              },
              child: Text('Achievements')),
        ],
      ),
    );
  }
}
