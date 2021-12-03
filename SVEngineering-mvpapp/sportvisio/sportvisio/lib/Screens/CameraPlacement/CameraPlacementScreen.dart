import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';

class CameraPlacement extends StatefulWidget {
  const CameraPlacement({Key? key}) : super(key: key);

  @override
  _CameraPlacementState createState() => _CameraPlacementState();
}

class _CameraPlacementState extends State<CameraPlacement> {
  final _navigationService = locator.get<NavigationHelper>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                color: HexColor("#3E3E3E"),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: Offset(0, 3.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: 20,
                    bottom: 10,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 18.0,
                          color: Colors.white,
                          height: 0.94,
                        ),
                        children: [
                          TextSpan(
                            text: 'Camera Placement\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                '1. Use a tripod and make sure the camera is stable\n2. Place camera at center court facing left our right\n3. Camera should have clear view of basket and court lines',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                  ),
                  customBnner(navigationService: _navigationService),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "images/ground.png",
                            ))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Container(
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Camera Details\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          WidgetSpan(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Arena\nCourt  |  Side of Court\n',
                              ),
                              Container(
                                transform: Matrix4.translationValues(0, -15, 0),
                                child: InkWell(
                                  onTap: () {
                                    _navigationService
                                        .navigateTo(AppRoutes.UPDATE_CAMERA);
                                  },
                                  child: Icon(
                                      IconData(57882,
                                          fontFamily: 'MaterialIcons'),
                                      color: HexColor("#30BCED"),
                                      size: 30),
                                ),
                              )
                            ],
                          )),
                          TextSpan(
                            text: 'Upcoming Game\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          WidgetSpan(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Team vs. Team  |  1pm - 2:30pm\n\n',
                              ),
                              Container(
                                transform: Matrix4.translationValues(0, -15, 0),
                                child: InkWell(
                                  onTap: () {
                                    _navigationService
                                        .navigateTo(AppRoutes.UPDATE_GAME);
                                  },
                                  child: Icon(
                                      IconData(57882,
                                          fontFamily: 'MaterialIcons'),
                                      color: HexColor("#30BCED"),
                                      size: 30),
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
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
