import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  var text;
  var onPress;
  CustomButton({this.onPress, this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
    
      minWidth: MediaQuery.of(context).size.width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPress,
      child: Center(
        child: Text(
          text,
          style:
              TextStyle(color: Colors.white, fontSize: 22, fontFamily: "bold"),
        ),
      ),
    );
  }
}
