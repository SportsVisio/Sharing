import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/data_models/live_stream_play_confirmation_arguments.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/main.dart';

class LiveStreamScreen extends StatefulWidget {
  @override
  _LiveStreamScreenState createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  final _navigationService = locator.get<NavigationHelper>();

  bool isPlay = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      border: Border.all(width: 7, color: Colors.red),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/streamvideo.png"),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final arguments = LiveStreamPlayConfirmationArguments(
                        isPlay: isPlay,
                        callback: (value) {
                          if (value == "yes") {
                            setState(() {
                              isPlay = !isPlay;
                              print(isPlay.toString());
                            });
                          }
                        },
                      );
                      _navigationService.navigateTo(
                        AppRoutes.LIVE_STREAM_PLAY_CONFIRMATION,
                        arguments: arguments,
                      );
                    },
                    child: Image.asset(isPlay
                        ? "images/playbutton.png"
                        : "images/pausebutton.png"),
                  )
                ],
              ),
            ),
            
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'State  | Arena\nCourt  |  Side of Court\n',
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
                                  .navigateTo(AppRoutes.SETUP_RECORD);
                            },
                            child: Image.asset(
                              "images/edit.png",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getData() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var username = pref.getString("name");
    var password = pref.getString("password");
    try {
      final String result = await channelName.invokeMethod('sendToken',
          {"text": token, "username": username, "password": password});
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }
}
