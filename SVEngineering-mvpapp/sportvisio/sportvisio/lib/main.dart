// @dart=2.9

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sportvisio/app/app_router.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/user_service.dart';
import 'package:sportvisio/core/view_models/arena_viewModel.dart';
import 'package:sportvisio/core/view_models/games_viewModel.dart';
import 'package:sportvisio/core/view_models/leagues_viewModel.dart';
import 'package:sportvisio/core/view_models/login_viewModel.dart';
import 'package:sportvisio/core/view_models/teams_viewModel.dart';

final userPool = CognitoUserPool(
  'us-east-1_66HUKi0kQ',
  '3ufu0d3dvoi8ri4gva0mpgvprg',
);

final channelName = MethodChannel('sports/stream');

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _providers = [
    ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
    ChangeNotifierProvider<ArenaViewModel>(create: (_) => ArenaViewModel()),
    ChangeNotifierProvider<LeaguesViewModel>(create: (_) => LeaguesViewModel()),
    ChangeNotifierProvider<GamesViewModel>(create: (_) => GamesViewModel()),
    ChangeNotifierProvider<TeamsViewModel>(create: (_) => TeamsViewModel()),
    ChangeNotifierProvider<UserServiceViewModel>(
        create: (_) => UserServiceViewModel()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        title: 'SportsVisio',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "regu"),
        navigatorKey: navigatorKey,
        initialRoute: AppRoutes.SPLASH,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

// use this function to start the native streamin+g activity.
/*Future<void> _proceedStreaming() async {
    try {
      final String result = await platform.invokeMethod('sendToken');
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {+®
      debugPrint("Error: '${e.message}'.");
    }
  }*/
}
