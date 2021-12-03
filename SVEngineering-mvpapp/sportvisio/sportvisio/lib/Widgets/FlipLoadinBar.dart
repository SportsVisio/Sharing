import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

class FlipLoadingBar extends StatelessWidget {
  const FlipLoadingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customFlip(color: Colors.red, mellis: 500),
          customFlip(color: HexColor("#FF5D00"), mellis: 1000),
          customFlip(color: HexColor("#FF5D00"), mellis: 1500),
          customFlip(color: HexColor("#FFE600"), mellis: 500),
          customFlip(color: HexColor("#FFE600"), mellis: 3000),
          customFlip(color: HexColor("#FFE600"), mellis: 500),
          customFlip(color: HexColor("#C5FF00"), mellis: 900),
          customFlip(color: HexColor("#C5FF00"), mellis: 500),
          customFlip(color: HexColor("#C5FF00"), mellis: 500),
          customFlip(color: HexColor("#00FF32"), mellis: 2500),
          customFlip(color: HexColor("#00FF32"), mellis: 1500),
          customFlip(color: HexColor("#00FF32"), mellis: 500),
          customFlip(color: HexColor("#00FF32"), mellis: 500),
          customFlip(color: HexColor("#00FF32"), mellis: 500),
          customFlip(color: HexColor("#00FF32"), mellis: 1500),
        ],
      ),
    );
  }

  Widget customFlip({var color, var mellis}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: LoadingFlipping.square(
        borderColor: Colors.transparent,
        size: 12.0,
        backgroundColor: color,
        duration: Duration(milliseconds: mellis),
      ),
    );
  }
}
