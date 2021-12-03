import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String? text;
  final TextEditingController? controller;
  final bool? isObscure;
  final Function(String)? onChanged;

  CustomTextField({
    this.controller,
    this.hint,
    this.isObscure,
    this.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            obscureText: isObscure != null ? isObscure! : false,
            controller: this.controller,
            onChanged: onChanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: HexColor("#D5D5D5"))),
          ),
        ),
      ),
    );
  }
}
