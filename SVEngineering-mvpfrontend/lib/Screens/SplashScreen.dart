import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mvp/app/app_routes.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/auth_helper.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          _navigationService.navigateTo(AppRoutes.DASHBOARD);
        } else {
          _navigationService.replace(AppRoutes.LOGIN);
        }
      },
    );
  }

  @override
  void dispose() {
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
