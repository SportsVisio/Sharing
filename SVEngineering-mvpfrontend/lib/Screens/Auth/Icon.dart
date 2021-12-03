import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';

class AnimateIcon extends StatefulWidget {
  final isFromDashBoard;
  final title;
  AnimateIcon({this.isFromDashBoard, this.title});
  @override
  _AnimateIconState createState() => _AnimateIconState();
}

class _AnimateIconState extends State<AnimateIcon> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return animateIcon(size);
  }

  Container animateIcon(Size size) {
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
                    UIHelper.verticalSpaceSm,
                  ],
                ),
                Spacer(),
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
                  children: <Widget>[],
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
}
