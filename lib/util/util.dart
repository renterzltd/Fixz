import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static Map<String, String> toPair(List<String> list) {
    Map<String, String> map = {};

    bool swi = true;
    String lastKey = "";
    list.forEach((it) {
      if (swi) {
        lastKey = it;
        map[it] = "";
      } else {
        map[lastKey] = it;
      }
      swi = !swi;
    });

    return map;
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

bool validateEmailAddress(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

showAlertDialog(BuildContext context, String title, String message,
    Function(bool) onPressed,
    {bool isSingleBtn = false}) {
  // set up the button

  Widget ok = CupertinoDialogAction(
    onPressed: () {
      onPressed(true);
      Navigator.of(context).pop();
    },
    isDefaultAction: true,
    child: Text("OK"),
  );

  Widget cancel = CupertinoDialogAction(
    onPressed: () {
      onPressed(false);
      Navigator.of(context).pop();
    },
    isDefaultAction: true,
    isDestructiveAction: true,
    child: Text("CANCEL"),
  );

  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      onPressed(true);
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = TextButton(
    child: Text("CANCEL"),
    onPressed: () {
      onPressed(false);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: isSingleBtn
        ? [
            okButton,
          ]
        : [
            cancelButton,
            okButton,
          ],
  );

  CupertinoAlertDialog iOSAlert = CupertinoAlertDialog(
    title: Text(title),
    content: Text(message),
    actions: isSingleBtn
        ? [
            ok,
          ]
        : [
            cancel,
            ok,
          ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return iOSAlert;
        // return alert;
      } else {
        return alert;
      }
    },
  );
}

setPlacehoderImg(double height, double width) {
  return Image(
    height: height,
    width: width,
    fit: BoxFit.fill,
    image: const AssetImage('assets/images/loading.gif'),
  );
}

setNetworkImage(String imgURl, double height, double width) {
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imgURl,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => setPlacehoderImg(height, width),
    errorWidget: (context, url, error) => setPlacehoderImg(height, width),
  );
}

getStringwithNewLine(String value) {
  final strArray = value.split(',');
  return strArray.join('\n');
}

Widget _setCommonButton(
    {required BuildContext context,
    required String btnTitle,
    required Function() onClick}) {
  return InkWell(
    onTap: () async {
      onClick.call();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          btnTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

showNotificationPermissionDialog(BuildContext context) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Permission needed",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
    content: const Text(
      "For the best app experience, please allow push notifications.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    actions: [
      _setCommonButton(
          context: context,
          btnTitle: 'Allow',
          onClick: () async {
            Navigator.of(context).pop();
            await AppSettings.openNotificationSettings();
            // await AppSettings.openAppSettings(
            //     type: AppSettingsType.notification);
          }),
      const SizedBox(height: 20),
      _setCommonButton(
          context: context,
          btnTitle: 'Don\'t Allow',
          onClick: () {
            Navigator.of(context).pop();
          }),
      const SizedBox(height: 20),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
