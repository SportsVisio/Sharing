import 'package:flutter/material.dart';

class BackgroundIconSearch extends StatelessWidget {
  const BackgroundIconSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      top: 50,
      child: Image.asset(
        "images/search.png",
        width: 80,
        height: 80,
      ),
    );
  }
}
