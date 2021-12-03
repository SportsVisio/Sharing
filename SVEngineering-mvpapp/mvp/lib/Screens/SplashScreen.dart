import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/app/app_routes.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _navigationService = locator.get<NavigationHelper>();
  double logoWidth = 250;
  double logoHeight = 250;
  bool isEmpty = true;
  late AnimationController animationController;
  late AnimationController animationControllerText;
  late Animation<Offset> animationText;
  late Animation<double> animationLogo;

  void updateLogo() {
    setState(() {
      logoWidth = 250;
      logoHeight = 250;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        isEmpty = false;
      });
    });
    updateLogo();
    animationControllerText = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    animationLogo = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationText = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(animationControllerText);
    // animation = CurvedAnimation(
    //     parent: animationController, curve: Curves.fastOutSlowIn);
    Timer(
      Duration(milliseconds: 3500),
      () => _navigationService.replace(AppRoutes.DASHBOARD),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    animationControllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    animationController.forward();
    animationControllerText.forward();

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: !isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "logomove",
                    child: Image.asset(
                      "images/logoredwhitevertical.png",
                      width: logoWidth,
                      height: logoHeight,
                    ),
                  ),
                  SlideTransition(
                    position: animationText,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 50,
                      ),
                      child: SizedBox(
                        width: 185.0,
                        child: Text(
                          'Player and team\nstats and videos\nat your fingertips.',
                          style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 20,
                            color: const Color(0xffbcbcbc),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}
