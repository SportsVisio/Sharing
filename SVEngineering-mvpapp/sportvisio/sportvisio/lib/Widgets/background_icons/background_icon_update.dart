import 'package:flutter/material.dart';

class BackgroundIconUpdate extends StatelessWidget {
  const BackgroundIconUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      top: 70,
      child: Image.asset(
        "images/history.png",
        width: 80,
        height: 80,
      ),
    );
  }
}
