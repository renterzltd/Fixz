// ignore_for_file: prefer_const_constructors

import 'package:fixz/hdHelper/appImages.dart';
import 'package:fixz/hdHelper/exportFile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  List<LANGUAGE> languageList = [];
  List<LANGUAGE> languageFilterList = [];

  var selectedLanguage = 'English';

  @override
  void onInit() {
    // TODO: implement onInit
    _fillLanguages();
    super.onInit();
  }

  _fillLanguages() {
    final tmp = [
      LANGUAGE('English', APPIMAGES.usa, false, Locale('en', 'US'), 'ENG'),
      LANGUAGE('Arabic', APPIMAGES.ksa, false, Locale('ar', 'EG'), 'ARB'),
    ];
    languageList = tmp;
    _checkLanguageStatuAndKSAStatus();
  }

  _checkLanguageStatuAndKSAStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final lan = prefs.getString(DEFAULTKEYS.selectedLanguage);
    if (lan != null) {
      if (lan == 'English') {
        languageList[0].isSelect = true;
      } else {
        languageList[1].isSelect = true;
      }
      update();
    }
    update();
  }

  updateValue(int index) {
    for (var item in languageList) {
      item.isSelect = false;
    }
    languageList[index].isSelect = !languageList[index].isSelect;
    languageFilterList = languageList.where((i) => i.isSelect).toList();
    update();
  }

  saveLanguage() async {
    if (languageFilterList.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          DEFAULTKEYS.selectedLanguage, languageFilterList.first.title);

      selectedLanguage = languageFilterList[0].title;
      update();
      Get.updateLocale(languageFilterList[0].local);
      return NavigationService()
          .setNavigator(HomeTabbarScreen(), isRemoveAll: true);
    } else {
      AlertClass.shared.setSnackbar('Please select language'.tr);
    }
  }
}

class LANGUAGE {
  String title;
  String imgFlag;
  bool isSelect;
  Locale local;
  String languageCode;
  LANGUAGE(
      this.title, this.imgFlag, this.isSelect, this.local, this.languageCode);
}
