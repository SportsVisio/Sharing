import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SportsVisioFormField extends StatelessWidget {
  final String? hint;
  final String? text;
  final TextEditingController? controller;
  final bool? isObscure;
  final FormFieldValidator<String>? validator;
  final bool required;
  final TextInputType? keyboardType;
  final bool isEnabled;
  final bool isReadOnly;

  SportsVisioFormField(
      {this.controller,
      this.hint,
      this.isObscure,
      this.text,
      this.validator,
      this.required = true,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.keyboardType});

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
          child: TextFormField(
            enabled: isEnabled,
            readOnly: isReadOnly,
            validator: required
                ? validator != null
                    ? validator
                    : defaultValidator
                : null,
            obscureText: isObscure != null ? isObscure! : false,
            controller: this.controller,
            keyboardType:
                keyboardType != null ? keyboardType : TextInputType.text,
            onChanged: (value) {},
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: HexColor("#D5D5D5")),
            ),
          ),
        ),
      ),
    );
  }

  String? defaultValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
