import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp/core/constants/Colors.dart';

class ConfirmDialog extends StatelessWidget {
  final String playerName;
  final animationForAddButton;
  const ConfirmDialog(this.playerName, this.animationForAddButton, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animationForAddButton,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .3,
            decoration: BoxDecoration(
                color: MyColors.redColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Remove $playerName' + '\n',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 20,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                    height: 0.625,
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'from your follow \n\n list?\n',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 18,
                    color: const Color(0xffffffff),
                    height: 0.625,
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 50,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.amber[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: Text(
                            'YES',
                            style: TextStyle(
                                fontFamily: 'regu',
                                fontSize: 18,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                                height: 0.625,
                                letterSpacing: .9),
                          )),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.greenAccent[700],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              letterSpacing: .9,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'regu',
                              fontSize: 18,
                              color: const Color(0xffffffff),
                              height: 0.625,
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
