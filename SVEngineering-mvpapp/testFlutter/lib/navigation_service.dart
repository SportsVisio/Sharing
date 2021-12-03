// import 'package:flutter/material.dart';
//
// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
//
// class NavigationService {
//   static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
//     return navigatorKey.currentState
//         .pushNamed(routeName, arguments: arguments);
//   }
//
//   static Future<dynamic> replace(String routeName, {dynamic arguments}) {
//     return navigatorKey.currentState
//         .pushReplacementNamed(routeName, arguments: arguments);
//   }
//
//   static pop() {
//     return navigatorKey.currentState.pop();
//   }
//
//   static popAllAndNavigateTo(String routeName) {
//     return navigatorKey.currentState
//         .pushNamedAndRemoveUntil(routeName, (route) => false);
//   }
// }
