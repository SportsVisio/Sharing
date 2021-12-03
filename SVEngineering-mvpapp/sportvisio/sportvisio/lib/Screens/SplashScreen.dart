import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/user_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _navigationService = locator.get<NavigationHelper>();
  double logoWidth = 0;
  double logoHeight = 0;
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
      () async {
        var pref = await SharedPreferences.getInstance();
        if (pref.containsKey("islogin") && pref.getBool("islogin") == true) {
          final postMdl =
              Provider.of<UserServiceViewModel>(context, listen: false);
          postMdl.ExchangeToken(pref.getString("token")).then((value) async {
            print(value.body + ">>>>>");
            if (value.statusCode == 200) {
              var data = json.decode(value.body);
              print(data['token']);
              pref.setString("token", data['token']);
            } else {
              _navigationService.navigateTo(AppRoutes.LOGIN);
            }
          });
          _navigationService.navigateTo(AppRoutes.MAIN_MENU);
        } else {
          _navigationService.replace(AppRoutes.LOGIN);
        }
      },
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
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/gradientbackground.png"))),
        child: !isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: animationLogo,
                    child: Image.asset(
                      "images/logo.png",
                      width: logoWidth,
                      height: logoHeight,
                    ),
                  ),
                  SlideTransition(
                    position: animationText,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      child: Text(
                        'AI Generated Stats and Highlight Reels in Real-Time',
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 28.0,
                          color: Colors.white,
                          height: 1.07,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
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
