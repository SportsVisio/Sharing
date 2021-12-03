import 'package:flutter/material.dart';
import 'package:mvp/Screens/Watching/GridItem.dart';
import 'package:mvp/Screens/Watching1/LiveStreamItem.dart';
import 'package:mvp/Screens/Watching1/StreamingText.dart';
import 'package:mvp/Screens/Watching1/WatchingItem.dart';

class WatchingScreen extends StatefulWidget {
  final animationForAddButton;
  const WatchingScreen(this.animationForAddButton, {Key? key})
      : super(key: key);
  //const WatchingScreen({Key? key}) : super(key: key);

  @override
  _WatchingScreenState createState() => _WatchingScreenState();
}

class _WatchingScreenState extends State<WatchingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      return WatchingItem(
                          'images/hawks.png', ['Hawks', 'Bullets']);
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: LiveStreamItem(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: StreamingText(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
