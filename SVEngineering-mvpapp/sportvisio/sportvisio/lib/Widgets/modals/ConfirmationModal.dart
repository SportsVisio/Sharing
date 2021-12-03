import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/Widgets/CustomBorderButton.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget content;
  final Function() onYes;
  final Function() onNo;
  final bool? loading;

  const ConfirmationModal({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onYes,
    required this.onNo,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor("#DE631C"),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: titleStyle,
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: bodyStyle,
                ),
                UIHelper.verticalSpaceL,
                Expanded(child: content),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBorderButton(
                        loading: loading ?? false,
                        backgroundColor: Colors.green,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        text: "Yes",
                        onPress: onYes),
                    CustomBorderButton(
                        backgroundColor: Colors.red,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        text: "No",
                        onPress: onNo),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12, top: 12),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "images/question.png",
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
