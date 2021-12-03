import 'package:flutter/material.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/app/app_routes.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/backgroundwithbanner.png"))),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Image.asset(
              "images/logo.png",
              width: 200,
              height: 200,
            ),
            Spacer(),
            MaterialButton(
              color: Constants.darkOrangeColor,
              minWidth: size.width,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                _navigationService.navigateTo(AppRoutes.CAMERA_MESSAGE_STATUS);
              },
              child: Text(
                "Record Game",
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontFamily: "bold"),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: MaterialButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  _navigationService.navigateTo(AppRoutes.SETUP_RECORD);
                },
                child: Text(
                  "Advanced Setup",
                  style: TextStyle(
                      color: Constants.blueColor,
                      fontSize: 18,
                      fontFamily: "regu"),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

