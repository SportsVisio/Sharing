import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/Widgets/CustomBorderButton.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';

class CameraUpdateConfirmationScreen extends StatefulWidget {
  const CameraUpdateConfirmationScreen({Key? key}) : super(key: key);

  @override
  _CameraUpdateConfirmationScreenState createState() =>
      _CameraUpdateConfirmationScreenState();
}

class _CameraUpdateConfirmationScreenState
    extends State<CameraUpdateConfirmationScreen> {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor("#DE631C"),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "images/corner2.png",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 30,
              top: 70,
              child: Image.asset(
                "images/question.png",
                width: 80,
                height: 80,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                height: size.height,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Spacer(),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 30.0,
                          color: Colors.white,
                          height: 1.0,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        children: [
                          TextSpan(
                            text: 'Is this correct?\n',
                          ),
                          TextSpan(
                            text: 'You are about to update\nthis camera',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    updatedFields(title: "State", value: ""),
                    updatedFields(title: "Arena", value: ""),
                    updatedFields(title: "Court", value: ""),
                    updatedFields(title: "Side of Court", value: ""),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomBorderButton(
                            backgroundColor: Colors.green,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            text: "Yes",
                            onPress: () {
                              _navigationService.pop(count: 2);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        CustomBorderButton(
                            backgroundColor: Colors.red,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            text: "No",
                            onPress: () {
                              _navigationService.pop();
                            }),
                      ],
                    ),
                    Spacer(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row updatedFields({var title, var value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 120,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 18.0,
              color: Colors.white,
              height: 1.0,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.16),
                  offset: Offset(0, 3.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Text(value),
        Spacer(),
      ],
    );
  }
}
