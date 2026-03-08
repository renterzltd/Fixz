import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StateUtil on State {
  void finish() {
    Navigator.of(this.context).pop();
  }

  void showToast(msg) {
    if (msg == null)
      msg = "Error";
    Fluttertoast.showToast(msg: msg);
  }

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  double getWidth(){
    return MediaQuery.of(context).size.width;
  }

  double getHeight() {
    return MediaQuery
        .of(context)
        .size
        .height;
  }
}
