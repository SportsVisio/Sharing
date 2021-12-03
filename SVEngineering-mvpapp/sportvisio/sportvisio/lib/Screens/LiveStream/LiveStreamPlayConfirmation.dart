import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/Widgets/CustomBorderButton.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';

class LiveStreamPlayConfirmationScreen extends StatefulWidget {
  LiveStreamPlayConfirmationScreen({required this.isPlay, this.callback});

  dynamic callback;
  bool isPlay;

  @override
  _LiveStreamPlayConfirmationScreenState createState() =>
      _LiveStreamPlayConfirmationScreenState();
}

class _LiveStreamPlayConfirmationScreenState
    extends State<LiveStreamPlayConfirmationScreen> {
  bool isPlayAndNoClick = false;

  final _navigationService = locator.get<NavigationHelper>();

  Row updatedFields({var title, var value}) {
    return Row(
      children: [
        Container(
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
      ],
    );
  }

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
                            text: widget.isPlay
                                ? "You are about to START recording"
                                : "You are about to STOP recording",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    updatedFields(
                        title: "10.10.15 @ 1:30pm - 2:30pm", value: ""),
                    updatedFields(title: "Maine", value: ""),
                    updatedFields(title: "Cross Center @ Court 2", value: ""),
                    updatedFields(title: "Men's League", value: ""),
                    updatedFields(title: "Celtics vs Bulls", value: ""),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBorderButton(
                            backgroundColor: Colors.green,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            text: "Yes",
                            onPress: () {
                              widget.callback("yes");
                              _navigationService.pop();
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        CustomBorderButton(
                            backgroundColor: !isPlayAndNoClick
                                ? Colors.red
                                : Colors.red.shade400,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            text: "No",
                            onPress: !isPlayAndNoClick
                                ? () {
                                    if (!widget.isPlay) {
                                      _navigationService.pop();
                                    } else {
                                      setState(() {
                                        isPlayAndNoClick = true;
                                      });
                                    }
                                  }
                                : null),
                      ],
                    ),
                    isPlayAndNoClick
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                CustomBorderButton(
                                    backgroundColor: Colors.green,
                                    borderColor: Colors.white,
                                    textColor: Colors.white,
                                    text: "Edit Game",
                                    onPress: () {
                                      _navigationService
                                          .navigateTo(AppRoutes.UPDATE_GAME);
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomBorderButton(
                                    backgroundColor: Colors.red,
                                    borderColor: Colors.white,
                                    textColor: Colors.white,
                                    text: "Cancel Record",
                                    onPress: () {
                                      _navigationService.pop();
                                    }),
                              ],
                            ),
                          )
                        : Container(),
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
}
