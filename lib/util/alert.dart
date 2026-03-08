// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/exportFile.dart';
import 'package:fixz/util/navigationService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertClass {
  static final AlertClass _singleton = AlertClass._internal();
  factory AlertClass() => _singleton;
  AlertClass._internal();
  static AlertClass get shared => _singleton;

  setSnackbar(String title) {
    final snackBar = SnackBar(
      content: Text(title),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  shoAlertWindow(String message, {Function(bool)? buttonPress}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel".tr),
      onPressed: () {
        NavigationService().setPopNavigator();
        if (buttonPress != null) {
          buttonPress(false);
        }
      },
    );
    Widget continueButton = TextButton(
      child: Text("OK".tr),
      onPressed: () {
        NavigationService().setPopNavigator();
        if (buttonPress != null) {
          buttonPress(true);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  shoAlertWithSingleButton(String message, {Function(bool)? buttonPress}) {
    Widget continueButton = TextButton(
      child: Text(
        "OK".tr,
        style: TextStyle(
          color: AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
        NavigationService().setPopNavigator();
        if (buttonPress != null) {
          buttonPress(true);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
