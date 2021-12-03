import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/AddFollowingGrid.dart';
import 'package:mvp/Screens/AddFollowing.dart/HeroText.dart';

class AddFollowingScreen extends StatefulWidget {
  final size;
  const AddFollowingScreen({this.size, Key? key}) : super(key: key);

  @override
  _AddFollowingScreenState createState() => _AddFollowingScreenState();
}

class _AddFollowingScreenState extends State<AddFollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
      child: Column(
        children: [HeroText(widget.size), AddFollowingGrid()],
      ),
    );
  }
}
