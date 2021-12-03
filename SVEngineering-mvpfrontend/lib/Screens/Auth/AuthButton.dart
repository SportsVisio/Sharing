import 'package:flutter/material.dart';
import 'package:mvp/core/constants/Colors.dart';

class AuthButton extends StatelessWidget {
  final String? text;
  final Function? action;
  AuthButton({this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            action!();
          },
          child: Text(
            text!,
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: MyColors.redColor,
          ),
        ));
  }
}
