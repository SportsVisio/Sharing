import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvp/Screens/SettingDialog/SettingDialogModel.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';

class AddHeader extends StatefulWidget {
  final isFromDashBoard;
  final title;
  AddHeader({this.isFromDashBoard, this.title});
  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<AddHeader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return appBar(size);
  }

  Container appBar(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Brian\'s Dashboard',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 20,
                        color: const Color(0xffdb0303),
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    UIHelper.verticalSpaceSm,
                    Text(
                      'We know your dashboard looks a \nlittle barren right now -- not to worry. \nJust click the + buttons below to add \nplayers, teams, games, and regions!',
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 14,
                        color: const Color(0xffa1a1a1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Spacer(),
                Hero(
                  tag: "logomove",
                  child: Container(
                      height: 80,
                      margin: EdgeInsets.only(bottom: 20, left: 10),
                      width: 80,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: MyColors.primaryColor),
                      child: Image.asset(
                        "images/logoredwhitevertical.png",
                      )),
                )
              ],
            ),
          ),
          widget.isFromDashBoard == null
              ? Container(
                  width: size.width,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  color: MyColors.redColor,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'regu',
                      fontSize: 19.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }

  Container settingDialogItem(int index, {SettingDialogModel? model}) {
    return Container(
      decoration: myBoxDecoration(index, 2),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              model!.image,
              width: 60,
              height: 60,
            ),
            UIHelper.verticalSpaceSm,
            Text(
              model.title,
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 16.0,
                color: Colors.white,
                height: 1.13,
              ),
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpaceSm,
            Text(
              model.desc,
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 12.0,
                color: const Color(0xFFC9C9C9),
                height: 1.17,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(int index, int gridViewCrossAxisCount) {
    index++;
    return BoxDecoration(
      color: Colors.transparent,
      border: Border(
        left: BorderSide(
          //                   <--- left side
          color: index % gridViewCrossAxisCount != 0
              ? Colors.transparent
              : Color.fromRGBO(112, 112, 122, 0.5),
          width: 1.5,
        ),
        top: BorderSide(
          //                   <--- left side
          color: index > gridViewCrossAxisCount
              ? Color.fromRGBO(112, 112, 122, 0.5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
    );
  }
}
