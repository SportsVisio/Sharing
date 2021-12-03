/*
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sports_visio/navigation_service.dart';
import 'package:sports_visio/routers.dart';
import 'package:sports_visio/screens/sign_in_screen.dart';
import 'package:sports_visio/screens/sign_up_screen.dart';
import 'package:sports_visio/screens/user_details_screen.dart';
import 'amplifyconfiguration.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await _configureAmplify();
  runApp(MyApp());
}

Future _configureAmplify() async {
  // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
  // AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();


  // AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  // Amplify.addPlugins([authPlugin]);
  // // Once Plugins are added, configure Amplify
  // // Note: Amplify can only be configured once.
  // try {
  //   await Amplify.configure(amplifyconfig);
  // } on AmplifyAlreadyConfiguredException {
  //   print(
  //       "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports Visio',
      theme: ThemeData(primarySwatch: Colors.blue),
      // navigatorKey: navigatorKey,
      // onGenerateRoute: Routes.onGenerateRoute,
      // initialRoute: SignInScreen.TAG,
    );
  }
}
*/
