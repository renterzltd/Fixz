// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AppColors {
//  BackgroundGrey,
  DarkGrey,
  LightGrey,
  FacebookBlue,
  LightText,
  BordersColor,
  BrightBlue,
  DarkBlue,
  LightTextGrey,
  White,
  Black,
  Orange,
  SimeColor,
  Red,
  colorPrimary,
  colorPrimaryDark,
  colorAccent,
  app_blue,
  light_green,
  dark_blue,
  black,
  semi_black,
  blank_color,
  white,
  semi_white,
  gray_lowest,
  blank_gray_low,
  gray_low,
  gray,
  gray_mid,
  transparent,
  orange,
  red,
  semi_color,
  appBarBlack,
  darkBlue,
  whiteAlfa,
  gray1,
  darkblue1,
  facebookBlue,
}

extension AppColorGetter on AppColors {
  Color lightColorHex() {
    switch (this) {
//      case AppColors.BackgroundGrey:
//        return HexColor.fromHex("fafafa");
      case AppColors.darkblue1:
        return HexColor.fromHex("102A46");

      case AppColors.gray1:
        return HexColor.fromHex("cccccc");

      case AppColors.whiteAlfa:
        return HexColor.fromHex("ffffffff");

      case AppColors.darkBlue:
        return HexColor.fromHex("102A46");

      case AppColors.appBarBlack:
        return HexColor.fromHex("102A46");

      case AppColors.DarkGrey:
        return HexColor.fromHex("5b5b75");

      case AppColors.LightGrey:
        return HexColor.fromHex("eeeeee");

      case AppColors.FacebookBlue:
        return HexColor.fromHex("3b5998");

      case AppColors.LightText:
        return HexColor.fromHex("aaaaaa");

      case AppColors.BordersColor:
        return HexColor.fromHex("EDEDED");

      case AppColors.BrightBlue:
        return HexColor.fromHex("1655C4");
      case AppColors.DarkBlue:
        return HexColor.fromHex("0D2F74");
      case AppColors.LightTextGrey:
        return HexColor.fromHex("333333");

      case AppColors.White:
        return HexColor.fromHex("ffffff");

      case AppColors.Black:
        return HexColor.fromHex("000000");

      case AppColors.Orange:
        return HexColor.fromHex("f9aa33");

      case AppColors.Red:
        return HexColor.fromHex("FB3640");
      case AppColors.SimeColor:
        return HexColor.fromHex("00ffffff");

      case AppColors.colorPrimary:
        return HexColor.fromHex("FFC187");

      case AppColors.colorPrimaryDark:
        return HexColor.fromHex("FFA957");

      case AppColors.colorAccent:
        return HexColor.fromHex("62B1DB");

      case AppColors.app_blue:
        return HexColor.fromHex("0A85C6");

      case AppColors.light_green:
        return HexColor.fromHex("47CE83");

      case AppColors.dark_blue:
        return HexColor.fromHex("454F61");

      case AppColors.black:
        return HexColor.fromHex("000000");

      case AppColors.semi_black:
        return HexColor.fromHex("7E7E7E");

      case AppColors.blank_color:
        return HexColor.fromHex("00FFFFFF");

      case AppColors.white:
        return HexColor.fromHex("ffffff");

      case AppColors.semi_white:
        return HexColor.fromHex("BBFFFFFF");

      case AppColors.gray_lowest:
        return HexColor.fromHex("F0F3F3F3");

      case AppColors.blank_gray_low:
        return HexColor.fromHex("28CCCBCB");

      case AppColors.gray_low:
        return HexColor.fromHex("efe2dede");

      case AppColors.gray:
        return HexColor.fromHex("aaaaaa");

      case AppColors.gray_mid:
        return HexColor.fromHex("777777");

      case AppColors.transparent:
        return HexColor.fromHex("00ffffff");

      case AppColors.orange:
        return HexColor.fromHex("FF9735");

      case AppColors.red:
        return HexColor.fromHex("FF0000");

      case AppColors.semi_color:
        return HexColor.fromHex("00ffffff");

      case AppColors.facebookBlue:
        return HexColor.fromHex("3A559F");
    }
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
