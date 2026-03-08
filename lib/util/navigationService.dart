// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  setNavigator(Widget screen, {bool isRemoveAll = false}) {
    if (isRemoveAll) {
      Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(navigatorKey.currentContext!)
          .push(MaterialPageRoute(builder: (_) => screen));
    }
  }

  setPopNavigator() {
    Navigator.of(navigatorKey.currentContext!).pop();
  }
}
