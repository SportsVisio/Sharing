import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/View/FollowingList.dart.dart';
import 'package:mvp/Screens/Auth/LoginScreen.dart';
import 'package:mvp/Screens/Auth/RegisterScreen.dart';
import 'package:mvp/Screens/Auth/UpdateProfile.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/EmailVerificationScreen.dart/EmailVerificationScreen.dart';
import 'package:mvp/Screens/Footer/Footer.dart';
import 'package:mvp/Screens/ResetPassword/ResetPasswordConfirmScreen.dart';
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
      case AppRoutes.FOOTER:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.fade,
            child: Footer(),
            duration: Duration(milliseconds: 1200));
      case AppRoutes.ADDFOLLOWING:
        return PageTransition(
            curve: Curves.linear,
            child: FollowingList(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 1200));
      case AppRoutes.EMAIL_VERIFICATION:
        return MaterialPageRoute(builder: (_) => EmailVerificationScreen());
      case AppRoutes.RESET_PASSWORD_CONFIRMATION:
        return MaterialPageRoute(builder: (_) => ResetPasswordConfirmScreen());

      case AppRoutes.LOGIN:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.rightToLeft,
            child: LoginScreen(),
            duration: Duration(milliseconds: 1200));
      case AppRoutes.REGISTER:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.rightToLeft,
            child: RegisterScreen(),
            duration: Duration(milliseconds: 1200));
      case AppRoutes.UPDATEPROFILE:
        return PageTransition(
            curve: Curves.linear,
            type: PageTransitionType.rightToLeft,
            child: UpdateProfile(),
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
