import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

@lazySingleton
class NavigationHelper {
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replace(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  pop({int count = 0}) {
    if (count > 0) {
      return navigatorKey.currentState!.popUntil((_) => count-- == 0);
    }
    return navigatorKey.currentState!.pop();
  }

  popUntil(String routeName) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  popAllAndNavigateTo(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}
