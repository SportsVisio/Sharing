import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final String color;

  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.color = '#10B430'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      color: HexColor(color),
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
