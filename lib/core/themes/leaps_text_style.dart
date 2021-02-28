import 'package:flutter/material.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

const TextStyle dropDownLabelStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);

const TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 16.0);

TextStyle headerStyle({
  double fontSize = 20.0,
  FontWeight fontWeight = FontWeight.w600,
  Color textColor = AppColors.Black}) =>
    TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: AppFont.PrimaryFont
    );

TextStyle bodyStyle(
        {double fontSize = 14.0,
        Color fontColor = AppColors.PrimaryColor,
        FontWeight fontWeight}) =>
    TextStyle(
      color: fontColor,
      fontSize: fontSize,
      letterSpacing: 0.8,
      height: 1.2,
      fontWeight: fontWeight,
      fontFamily: AppFont.PrimaryFont
    );
