import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddPlayer/AchievementWidget.dart';
import 'package:mvp/Screens/AddPlayer/AddButton.dart';
import 'package:mvp/Screens/AddPlayer/AppBar.dart';
import 'package:mvp/Screens/AddPlayer/AddPlayerHeader.dart';
import 'package:mvp/Screens/AddPlayer/WatchLive.dart';

class AddPlayerScreen extends StatelessWidget {
  const AddPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: size.width,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AddHeader(
                            isFromDashBoard: true,
                          ),
                          SizedBox(height: 20),
                          AddPlayerHeader(
                            'Following',
                          ),
                          SizedBox(height: 20),
                          AddButton(size),
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          AddPlayerHeader(
                            'Watch Live',
                          ),
                          SizedBox(height: 20),
                          WatchLive(size),
                          SizedBox(height: 20),
                          AddPlayerHeader(
                            'Achievements',
                          ),
                          SizedBox(height: 20),
                          AchievementWidget(size)
                        ])))));
  }
}
