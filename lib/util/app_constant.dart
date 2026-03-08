// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:fixz/hdHelper/sharedManager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static const String PROPERTY = "property";
  static const String REQUEST_VISIT = "request_visit";
  static const String REQUEST_REPAIR = "repair";
}

String getCapitalizeString(String str) {
  if (str.length <= 1) {
    return str.toUpperCase();
  }
  return '${str[0].toUpperCase()}${str.substring(1)}';
}

String formatPrice(int price) {
  debugPrint('Price--------->$price');
  final formatter = NumberFormat.currency(locale: 'en_US', name: '');
  final test = formatter.format(price);
  var arr = test.split('.');
  return arr[0].toString();
}

var verification = '';
int? itemId;
int? itemIndex;
// String sellingPackage = '${SharedManager.shared.getCurrency}1,199';
String helpCall = '+442045381545';
String whatsAppNo = '447917991839';
String propertyID = '';
File? repairImage;
String mapKey = 'YOUR_GOOGLE_MAPS_API_KEY';
String repairRequestId = '';
String dummyProfile =
    'https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png';

//Strip TEST Key
// String stripKey =
//     'pk_test_51IPB8aGK6e7oDlOw0bqhHzKbflIMrRlbwNDIpx4OBKzHYMVaVehnhWk0dmFkjSKn50uzN865bIMmmcvMZp63nwSb00xk9qbHQO';

//Strip LIVE & TEST Key
String stripKey = kReleaseMode
    ? 'YOUR_STRIPE_LIVE_KEY'
    : 'YOUR_STRIPE_LIVE_KEY';

//SMS Code Stuff
String codeSMS = "";
String signature = "";
int indexSelected = 0;
int currentIndexHomeViewer = 0;
String convertDate(String date) {
  final dateFormate =
      DateFormat.yMMMMd('en_US').format(DateTime.parse("$date"));
  return dateFormate;
}

String convertDateForDifference(String date) {
  final dateFormate = DateFormat('yyyy-MM-dd').format(DateTime.parse("$date"));
  return dateFormate;
}

String convertTime(String date) {
  final dateFormate = DateFormat.jm().format(DateTime.parse("$date"));
  return dateFormate;
}

void showInSnackBarWithKey(
    String value, GlobalKey<ScaffoldState> key, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 30),
      content: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          SizedBox(width: 15),
          Text(value)
        ],
      )));
}

class WebUrls {
  static String baseUrl = !SharedManager.shared.isDubaiVersion
      ? 'https://renterz.com/'
      : 'https://renterz.ae/';
  static String webTerms = '${baseUrl}terms-conditions';
  static String webPolicy = '${baseUrl}privacy-policy';
  static String webCommunity = '${baseUrl}community-guidelines';
  static String webInsurance = '${baseUrl}insurance';
  static String webSupport = '${baseUrl}faqs';
}

class DEFAULTKEYS {
  static String selectedLanguage = 'SelectedLanguage';
  static String isSelectedKSA = 'isSelectedKSA';
  static String isFirstTimeInstalled = 'isFirstTimeInstalled';
  static String userName = 'userName';
}
