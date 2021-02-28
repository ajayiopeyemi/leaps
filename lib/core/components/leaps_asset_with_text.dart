import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class LeapsAssetWithText extends StatelessWidget {
  final bool isIcon;
  final IconData iconData;
  final String svg;
  final Color iconColor;
  final double iconSize;
  final String text;
  final Color textColor;
  final Color decorationColor;
  final double hPadding;
  final double customSpacer;
  final TextStyle textStyle;

  final bool isHorizontal;
  final bool needsDecoration;

  LeapsAssetWithText(
      {this.isIcon,
      this.iconData,
      this.svg,
      this.text,
      this.iconColor = AppColors.White,
      this.iconSize = 20.0,
      this.textColor = AppColors.PrimaryColor,
      this.decorationColor = AppColors.White,
      this.hPadding = 18.0,
      this.customSpacer = 8.0,
      this.textStyle,
      this.isHorizontal,
      this.needsDecoration = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 8.0),
      decoration: needsDecoration == true
          ? BoxDecoration(
              color: decorationColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            )
          : null,
      child: isHorizontal == true
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isIcon == true
                    ? Icon(
                        iconData,
                        size: iconSize,
                        color: iconColor,
                      )
                    : SvgPicture.asset(
                        svg,
                        width: iconSize,
                        height: iconSize,
                        color: iconColor,
                      ),
                AppDimensions.horizontalSpacer(spaceSize: customSpacer),
                Text(text, textAlign: TextAlign.center, style: textStyle)
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isIcon == true
                    ? Icon(
                        iconData,
                        size: iconSize,
                        color: iconColor,
                      )
                    : SvgPicture.asset(
                        svg,
                        width: iconSize,
                        height: iconSize,
                        color: iconColor,
                      ),
                AppDimensions.verticalSpacer(spaceSize: customSpacer),
                Text(text, textAlign: TextAlign.center, style: textStyle)
              ],
            ),
    );
  }
}
