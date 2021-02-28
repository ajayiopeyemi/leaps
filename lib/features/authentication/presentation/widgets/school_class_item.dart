import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/components/leaps_container.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class SchoolClassItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  SchoolClassItem({
    @required this.text,
    this.isSelected = false
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.screenWidth(context),
      child: LeapsContainer(
          borderRadius: 8.0,
          /*padding: 16.0,*/
          margin: 8.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Visibility(
                visible: isSelected,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.Purple,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppDimensions.verticalSpacer(spaceSize: 16.0),
                  Expanded(
                    child: SvgPicture.asset(
                      AppSVGs.university,
                      height: 40,
                    ),
                  ),
                  AppDimensions.verticalSpacer(),
                  Expanded(child: Text(text)),
                ],
              ),
            ],
          ),
          color: AppColors.White,
          shadowColor: Color(0xFFf3f4f6)
      ),
    );
  }
}
