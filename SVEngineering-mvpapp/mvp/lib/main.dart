import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'app/app_router.dart';
import 'app/app_routes.dart';
import 'app/locator.dart';
import 'core/helpers/navigation_helper.dart';
import 'core/view_models/login_viewModel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _providers = [
    ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        title: 'MVP',
        theme: ThemeData(
            primaryColor: HexColor("#333333"),
            primarySwatch: Colors.red,
            fontFamily: "regu"),
        navigatorKey: navigatorKey,
        initialRoute: AppRoutes.SPLASH,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

// use this function to start the native streaming activity.
/*Future<void> _proceedStreaming() async {
    try {
      final String result = await platform.invokeMethod('sendToken');
      debugPrint('Result: $result ');
    } on PlatformException catch (e) {
      debugPrint("Error: '${e.message}'.");
    }
  }*/
}
