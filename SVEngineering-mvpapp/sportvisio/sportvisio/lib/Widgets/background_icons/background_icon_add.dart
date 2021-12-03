import 'package:flutter/material.dart';

class BackgroundIconAdd extends StatelessWidget {
  const BackgroundIconAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      top: 70,
      child: Image.asset(
        "images/add.png",
        width: 80,
        height: 80,
      ),
    );
  }
}
