// ignore_for_file: file_names, unnecessary_const

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fixz/resources/colors.dart';
import 'package:flutter/material.dart';

mixin ButtonMixin {
  createButton(
      {double height = 40,
      double? width,
      Color? btnColour,
      Color? txtColor,
      double fontSize = 15,
      String text = '',
      Function? onBtnClick,
      DecoratedBox? boxDecoration,
      BorderRadius? borderRadius,
      FontWeight? weightFont,
      Widget? widget,
      bool hideGradient = false}) {
    return InkWell(
      onTap: () {
        if (onBtnClick != null) {
          onBtnClick();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: hideGradient ? btnColour : null,
          gradient: hideGradient
              ? null
              : const LinearGradient(
                  colors: [
                    const Color(0xFFFF824B),
                    const Color(0xFFFFB238),
                  ],
                  begin: const FractionalOffset(0.0, 0.5),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
          borderRadius: borderRadius ?? BorderRadius.circular(6),
        ),
        child: widget ??
            AutoSizeText(
              text,
              style: TextStyle(
                color: txtColor ?? AppColors.colorPrimary.lightColorHex(),
                fontSize: fontSize,
                fontWeight: weightFont ?? FontWeight.w500,
              ),
            ),
      ),
    );
  }
}
