import 'package:flutter/material.dart';

mixin TextFieldMixin<T extends StatefulWidget> on State<T> {
  setTextField({
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String hint = "",
    Color textColor = Colors.black,
    Color? hintColor,
    double fontSize = 12,
    Color? borderColor,
    bool isVisibleBorder = false,
    double? borderWidth,
    double? height,
    FocusNode? focusNode,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool isSecureText = false,
    bool isEditable = true,
    bool isHidenRoundBorder = false,
    bool isLabelHidden = false,
    Function(String)? onTextChange,
    EdgeInsetsGeometry? contentPadding,
    int? isMaxline,
    Function()? onTap,
    Function()? onEditingComplete,
  }) {
    return Container(
      height: height,
      // padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: isHidenRoundBorder
            ? const BoxDecoration()
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: borderColor ?? Colors.grey,
                ),
              ),
        child: TextFormField(
          focusNode: focusNode,
          enabled: isEditable,
          controller: controller,
          obscureText: isSecureText,
          keyboardType: keyboardType,
          maxLines: isMaxline ?? 1,
          onChanged: (val) {
            if (onTextChange != null) {
              onTextChange(val);
            }
          },
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            onEditingComplete?.call();
          },
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
              contentPadding:
                  contentPadding ?? EdgeInsets.only(top: 10, left: 5),
              disabledBorder: InputBorder.none,
              // enabledBorder: isVisibleBorder
              //     ? UnderlineInputBorder(
              //         borderSide: BorderSide(
              //             color: borderColor ??
              //                 AppColors.colorPrimary.lightColorHex()),
              //       )
              //     : null,
              // focusedBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(
              //       color:
              //           borderColor ?? AppColors.colorPrimary.lightColorHex()),
              // ),
              labelStyle: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
              hintStyle: TextStyle(
                color: hintColor ?? Colors.black,
                fontSize: fontSize,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              border: isVisibleBorder ? null : InputBorder.none,
              isDense: true,
              // labelText: isLabelHidden ? '' : hint,
              hintText: hint),
        ),
      ),
    );
  }
}
