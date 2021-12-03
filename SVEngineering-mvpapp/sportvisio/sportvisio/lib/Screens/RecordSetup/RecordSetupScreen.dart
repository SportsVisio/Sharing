import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Widgets/CustomButton.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';

class RecordSetupScreen extends StatefulWidget {
  const RecordSetupScreen({Key? key}) : super(key: key);

  @override
  _RecordSetupScreenState createState() => _RecordSetupScreenState();
}

class _RecordSetupScreenState extends State<RecordSetupScreen> {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/backgroundwithbanner.png"))),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                  CustomButton(
                    text: "Camera Setup",
                    onPress: () {
                      _navigationService.navigateTo(AppRoutes.CAMERA_PLACEMENT);
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    text: "Schedules | Games",
                    onPress: () {
                      _navigationService.navigateTo(AppRoutes.SEARCH_GAME);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    text: "Rosters",
                    onPress: () {
                      _navigationService.navigateTo(AppRoutes.SEARCH_TEAM);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    text: "Arenas | Courts",
                    onPress: () {
                      // final postMdl =
                      //     Provider.of<ArenaViewModel>(context, listen: false);
                      // postMdl.getArenas().then((value) {
                      // });
                      _navigationService.navigateTo(AppRoutes.SEARCH_ARENA);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    text: "Leagues  |  Teams",
                    onPress: () {
                      _navigationService.navigateTo(AppRoutes.SEARCH_LEAGUE);
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
            customBnner(navigationService: _navigationService),
          ],
        ),
      ),
    );
  }
}
