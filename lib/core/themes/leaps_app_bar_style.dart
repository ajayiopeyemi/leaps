import 'package:flutter/material.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

AppBar leapsPrimaryAppBar({String title, Color appBarBak}) => AppBar(
      title: new Text(
        title,
        style:
            TextStyle(fontFamily: AppFont.PrimaryFont, color: AppColors.Black),
      ),

      elevation: 0.0,
      backgroundColor: appBarBak,
      centerTitle: true,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: AppColors.Black),
    );
