import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';

class AccentButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final bool? loading;

  const AccentButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      color: HexColor("#DE631C"),
      minWidth: size.width,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: buttonStyle.copyWith(color: Colors.white)),
          UIHelper.horizontalSpaceSm,
          loading!
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
    );
  }
}
