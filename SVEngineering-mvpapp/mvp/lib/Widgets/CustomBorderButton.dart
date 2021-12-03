import 'package:flutter/material.dart';
import 'package:mvp/app/styles.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';

class CustomBorderButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Function()? onPress;
  final bool loading;

  CustomBorderButton({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.text,
    this.onPress,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 120,
      height: 50,
      disabledColor: Colors.red[200],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 3, color: borderColor)),
      color: backgroundColor,
      onPressed: onPress,
      child: Center(
        child: Row(
          children: [
            Text(text, style: buttonStyle.copyWith(color: textColor)),
            UIHelper.horizontalSpaceSm,
            loading
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
