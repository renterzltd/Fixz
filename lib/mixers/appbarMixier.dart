// ignore_for_file: file_names

import 'package:fixz/resources/colors.dart';
import 'package:flutter/material.dart';

mixin AppbarMixin<T extends StatefulWidget> on State<T> {
  setAppbar(
    String title, {
    Color? textColor,
    Color? bgColor,
    Color? backIconColor,
    bool isTitleCenter = false,
    String? fontFamily,
    double? fontSize,
    double? elivation,
    List<Widget>? action,
    Function? onBackClick,
  }) {
    return AppBar(
      backgroundColor: bgColor ?? AppColors.colorPrimaryDark.lightColorHex(),
      centerTitle: isTitleCenter,
      elevation: elivation ?? 0.0,
      actions: action ?? [],
      leading: IconButton(
          onPressed: () {
            if (onBackClick != null) {
              onBackClick();
            }
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          )),
      iconTheme: IconThemeData(
        color: backIconColor ?? AppColors.colorPrimaryDark.lightColorHex(),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.colorPrimaryDark.lightColorHex(),
          fontSize: fontSize ?? 18,
        ),
      ),
    );
  }
}
