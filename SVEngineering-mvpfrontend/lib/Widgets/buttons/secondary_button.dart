import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SecondaryButton extends StatelessWidget {
  final Function() onPressed;
  final String label;

  const SecondaryButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      color: HexColor("#D21B1B"),
      minWidth: size.width,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}