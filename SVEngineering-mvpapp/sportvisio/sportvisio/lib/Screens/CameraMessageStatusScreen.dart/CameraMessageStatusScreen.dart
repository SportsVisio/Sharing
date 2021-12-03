import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Screens/LiveStream/LiveStreamPlayConfirmation.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/loading_widget.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/data_models/live_stream_play_confirmation_arguments.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/constants/api_endpoints.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/user_service.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/core/view_models/games_viewModel.dart';
import 'package:sportvisio/main.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:sportvisio/network/data_models/AccountModel.dart';

Future<dynamic> _handleMethod(MethodCall call) async {
  switch (call.method) {
    case "message":
      print("java????????????");
      return "okkkkkkkkk";
  }
}

class CameraMessageStatusScreen extends StatefulWidget {
  @override
  _CameraMessageStatusScreenState createState() =>
      _CameraMessageStatusScreenState();
}

class _CameraMessageStatusScreenState extends State<CameraMessageStatusScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  var token;
  var accountId;
  bool isLoading = false;
  @override
  void initState() {
    channelName.setMethodCallHandler(nativeMethodCallHandler);
    super.initState();
    getPref();
  }

  void getPref() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
      accountId = pref.getString("id");
    });
    String deviceid = await DeviceId.getID;
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    String startTimeStamp = timeStamp.toString();
    String endTimeStamp = (timeStamp + 1).toString();

    var payload = {
      "accountId": accountId,
      "deviceId": deviceid + endTimeStamp,
      "name": "video" + startTimeStamp + endTimeStamp
    };
    print(payload);
    final postMdl = Provider.of<GamesViewModel>(context, listen: false);
    postMdl.registerDevice(token, payload).then((value) {
      print(value.body.toString() + "++++");
    });
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    print('Native call!');
    switch (methodCall.method) {
      case "playstream":
        print("java play stream ???????????");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => LiveStreamPlayConfirmationScreen(
        //               isPlay: true,
        //               callback: (value) {},
        //             )));
        final arguments = LiveStreamPlayConfirmationArguments(
          isPlay: true,
          callback: (value) {
            if (value == "yes") {
              setState(() {});
            }
          },
        );
        // _navigationService.navigateTo(AppRoutes.LIVE_STREAM_PLAY_CONFIRMATION,
        //     arguments: arguments);
        return "This data from flutter.....";
      case "pausestream":
        print("java pause stream ???????????");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => LiveStreamPlayConfirmationScreen(
        //               isPlay: false,
        //               callback: (value) {},
        //             )));
        return "This data from flutter.....";
      default:
        return "Nothing";
    }
  }

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
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      responseFromNativeCode();
                      if (Platform.isAndroid) {
                        _handleCameraNotMoved();
                      } else if (Platform.isIOS) {
                        // getData();
                        _handleCameraNotMoved();
                      }
                    },
                    child: Text(
                      'Camera has not been moved',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 26.0,
                        color: const Color(0xFF0055FF),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO disabling it as requirement is not clear
                      //  _handleCameraMoved();
                      _handleCameraPlacementAndroid();
                    },
                    child: Text(
                      'If camera has been moved\nor has fallen/shifted app\nauto goes to\ncamera calibration',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 26.0,
                        color: Constants.blueColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            customBnner(navigationService: _navigationService),
            isLoading ? Center(child: LoadingWidget()) : Container()
          ],
        ),
      ),
    );
  }

  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result =
          await channelName.invokeMethod('helloFromNativeCode');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      print(response);
    });
  }

  void _handleCameraNotMoved() async {
    // _navigationService.navigateTo(AppRoutes.LIVE_STREAM);
    const platform = MethodChannel("sports/stream");
    var pref = await SharedPreferences.getInstance();

    var username = pref.getString("name");

    var password = pref.getString("password");
    var streamId = pref.getString("streamId");
    var token = pref.getString("token");
    var userid = pref.getString("id");
    setState(() {
      isLoading = true;
    });

    getRegisterDevices(token);
    // try {
    //   // final String result = await platform.invokeMethod('sendToken', {
    //   //   "username": username,
    //   //   "password": password,
    //   //   "streamId": streamId,
    //   //   "token": token,
    //   //   "id": userid
    //   // });
    //   //pref.setString("streamId", result);
    //   //debugPrint('Result: $result ');
    // } on PlatformException catch (e) {
    //   debugPrint("Error: '${e.message}'.");
    // }
  }

  void _handleCameraPlacementAndroid() async {
    // _navigationService.navigateTo(AppRoutes.LIVE_STREAM);
    const platform = MethodChannel("sports/stream");
    var pref = await SharedPreferences.getInstance();

    var username = pref.getString("name");

    var password = pref.getString("password");
    var streamId = pref.getString("streamId");
    var token = pref.getString("token");
    var userid = pref.getString("id");
    try {
      final String result = await platform.invokeMethod('sendTokenplace', {
        "username": username,
        "password": password,
        "streamId": streamId,
        "token": token,
        "id": userid
      });
      pref.setString("streamId", result);
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
    // final postMdl = Provider.of<UserServiceViewModel>(context, listen: false);
    // postMdl.ExchangeToken(token).then((value) async {
    //   print(value.body + ">>>>>");
    //   if (value.statusCode == 200) {
    //     var data = json.decode(value.body);
    //     print(data['token']);

    //   } else {
    //     _navigationService.navigateTo(AppRoutes.LOGIN);
    //   }
    // });
  }

  void _handleCameraMoved() async {
    _navigationService.navigateTo(AppRoutes.CAMERA_PLACEMENT);
  }

  void getData() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var username = pref.getString("name");
    var password = pref.getString("password");
    var userid = pref.getString("id");

    final postMdl = Provider.of<UserServiceViewModel>(context, listen: false);
    postMdl.ExchangeToken(token).then((value) async {
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        print(data['token']);
        try {
          final String result = await channelName.invokeMethod('sendToken', {
            "text": data['token'],
            "username": username,
            "password": password,
            "id": userid
          });
          debugPrint('Result: $result ');
        } on PlatformException catch (e) {
          debugPrint("Error: '${e.message}'.");
        }
      }
    });
  }

  Future<http.Response> getRegisterDevices(var token) async {
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response;
    try {
      response = await http.get(
          Uri.parse(ApiEndPoints.BASE_URL_SWAGGER + '/account/'),
          headers: headers);
    } catch (e) {
      print('error excchange: $e');
    }

    if (response.statusCode == 200) {
      print(await response.toString());
      AccountModel acModel = accountModelFromJson(response.body);
      var payload = {
        "description": "description",
        "leagueId": null,
        "courtId": null,
        "teams": [
          {"teamId": acModel.teams![0].id, "designation": "TeamA"},
          {"teamId": acModel.teams![1].id, "designation": "TeamB"}
        ],
        "startTime": 1631061820,
        "endTime": 1631071831
      };

      SheduleGame(token, payload);
    } else {
      print(response.reasonPhrase);
    }
    return response;
  }

  Future<ScheduledGame> getRegisterDevicesForFilter(var token, gameId) async {
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response;
    var scheduledGame;
    try {
      response = await http.get(
          Uri.parse(ApiEndPoints.BASE_URL_SWAGGER + '/account/'),
          headers: headers);
    } catch (e) {
      print('error excchange: $e');
    }

    if (response.statusCode == 200) {
      print(await response.toString());
      AccountModel acModel = accountModelFromJson(response.body);
      int index =
          acModel.scheduledGames!.indexWhere((element) => element.id == gameId);
      scheduledGame = acModel.scheduledGames![index];
      return scheduledGame;
    } else {
      print(response.reasonPhrase);
    }
    return scheduledGame;
  }

  Future<http.Response> registerDevice(token, payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var jsonRespose;
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.REGISTERDEVICE),
          headers: headers, body: payload);
    } catch (e) {
      print('error excchange: $e');
    }
    return jsonRespose;
  }

  Future SheduleGame(token, payload) async {
    const platform = MethodChannel("sports/stream");
    var pref = await SharedPreferences.getInstance();

    var username = pref.getString("name");

    var password = pref.getString("password");
    var streamId = pref.getString("streamId");
    var userid = pref.getString("id");
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    };
    print(token);
    print(payload);

    var jsonRespose;
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.GAMESCHEDULE),
          headers: headers, body: jsonEncode(payload));
      var data = json.decode(jsonRespose.body);
      var gameId = data['id'];
      print(data['id'].toString());
      setState(() {
        isLoading = false;
      });
      final String result = await platform.invokeMethod('sendToken', {
        "username": username,
        "password": password,
        "streamId": streamId,
        "token": token,
        "gameId": gameId,
        "id": userid,
      });
      pref.setString("streamId", result);
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {} catch (e) {
      print('error excchange: $e');
    }

    // var request = http.Request('POST',
    //     Uri.parse('https://dev.sportsvisio-api.com/account/games/schedule'));
    // request.body =
    //     '''{\n    "description": "",\n    "leagueId": null,\n    "courtId": null,\n    "teams": [\n        {\n            "teamId": "1825c9ec-2262-4b90-9934-eda63c1002c1",\n            "designation": "TeamA"\n        },\n        {\n            "teamId": "b0533c02-cb37-4787-bb3a-50fdbfab64fe",\n            "designation": "TeamB"\n        }\n    ],\n    "startTime": 1631061820,\n    "endTime": 1631071831\n}''';
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }
}
