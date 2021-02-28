import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class DropDownHelper{
  const DropDownHelper();
  static List<PopupMenuItem<int>> buildPopMenuItem(list){
    List<PopupMenuItem<int>> popupMenuItems = List();
    for(int i = 0; i < list.length; i++){
      popupMenuItems.add(PopupMenuItem(
        child: Text(
          list[i],
          style: bodyStyle(fontColor: AppColors.Black)
        ),
        value: i,
      ));
    }
    return popupMenuItems;
  }
}