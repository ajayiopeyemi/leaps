import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class ProfileScreenItem extends StatelessWidget {
  final String text, iconData;
  final VoidCallback onPress;
  ProfileScreenItem(this.text, this.iconData, this.onPress);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: AppDimensions.dimenEight,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LeapsAssetWithText(
                  isIcon: false,
                  isHorizontal: true,
                  svg: iconData,
                  iconSize: AppDimensions.screenWidth(context) * 0.05,
                  iconColor: AppColors.Purple,
                  text: text,
                  textStyle: bodyStyle(
                      fontSize: AppDimensions.dimenEighteen,
                      fontWeight: FontWeight.w300,
                      fontColor: AppColors.PrimaryColor),
                  customSpacer: AppDimensions.dimenTwentyFour,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: AppColors.PrimaryColor,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: AppColors.PrimaryColor,
          )
        ],
      ),
    );
  }
}
