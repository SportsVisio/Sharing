import 'package:flutter/material.dart';
import 'package:mvp/Widgets/MyCustomNav.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyCustomeNav1(3),
    );
  }
}
