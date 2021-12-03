import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvp/Screens/SettingDialog/SettingDialogModel.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';

class HeaderView extends StatefulWidget {
  var isFromDashBoard;
  var title;
  HeaderView({this.isFromDashBoard, this.title});
  @override
  _HeaderViewState createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  List<SettingDialogModel> listSettingDialgItems = [
    SettingDialogModel(
        title: "Following",
        desc: "Players, Teams,and Leagues",
        image: "images/follow.png"),
    SettingDialogModel(
        title: "Watch Live",
        desc: "Gamesand Tournaments",
        image: "images/view.png"),
    SettingDialogModel(
        title: "Favorites",
        desc: "Videos and Plays",
        image: "images/favorit.png"),
    SettingDialogModel(
        title: "Highlights", desc: "Top Plays", image: "images/highlight.png"),
    SettingDialogModel(
        title: "Achievements",
        desc: "Accomplishments and Streaks",
        image: "images/achieevement.png"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return headerView(size);
  }

  Container headerView(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
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
                            'Menu Items here once items added?',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'regu',
                              fontSize: 14,
                              color: const Color(0xffa1a1a1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      settingDialog(size);
                    },
                    child: Icon(
                      Icons.settings,
                      color: Colors.grey,
                    ),
                  ),
                  Hero(
                    tag: "logomove",
                    child: Container(
                        height: size.width * 0.2,
                        margin: EdgeInsets.only(bottom: 20, left: 10),
                        width: size.width * 0.2,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: MyColors.primaryColor),
                        child: Image.asset(
                          "images/logoredwhitevertical.png",
                        )),
                  )
                ],
              ),
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

  Future<Object?> settingDialog(Size size) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: Duration(milliseconds: 100),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        backgroundColor: MyColors.primaryColor,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Container(
            //  height: size.height * 0.5,
            width: size.width,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GridView.builder(
                      shrinkWrap: true,
                      controller: new ScrollController(keepScrollOffset: false),
                      itemCount: listSettingDialgItems.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 0.5),
                      itemBuilder: (BuildContext context, int index) {
                        return index < 5
                            ? settingDialogItem(index,
                                model: listSettingDialgItems[index])
                            : Container(
                                decoration: myBoxDecoration(index, 2),
                              );
                      },
                    ),
                  ],
                ),
              ),
            )),
        elevation: 2,
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
      context: context,
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
