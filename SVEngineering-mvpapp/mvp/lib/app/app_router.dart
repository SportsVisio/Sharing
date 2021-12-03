import 'package:flutter/material.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/SplashScreen.dart';
import 'package:page_transition/page_transition.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.DASHBOARD:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.fade,
            child: DashboardScreen(),
            duration: Duration(milliseconds: 1200));

      case AppRoutes.LOGIN:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.rightToLeft,
            //  child: LoginScreen(),
            duration: Duration(milliseconds: 1200));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
