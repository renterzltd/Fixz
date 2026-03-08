// ignore_for_file: unnecessary_new

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

setCommonText(String title,
    {dynamic color = Colors.black,
    double fontSize = 14,
    dynamic fontWeight = FontWeight.w500,
    dynamic noOfLine = 1,
    TextAlign textAlignment = TextAlign.start}) {
  return new AutoSizeText(
    title,
    textAlign: textAlignment,
    style: TextStyle(
      color: color,
      fontSize: double.parse(fontSize.toString()),
      fontWeight: fontWeight,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
    wrapWords: false,
    minFontSize: 12,
  );
}

setHeight(double value) {
  return SizedBox(
    height: value,
  );
}

setWidth(double value) {
  return SizedBox(
    width: value,
  );
}
