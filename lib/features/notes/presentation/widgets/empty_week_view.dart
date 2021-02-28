import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class EmptyWeekView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppDimensions.verticalSpacer(spaceSize: 16.0),
        Expanded(
          child: SvgPicture.asset(
              AppSVGs.Empty
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Expanded(
          child: Text(
            'There are no resource(s) in this week yet',
            textAlign: TextAlign.center,
            style:
            bodyStyle(fontSize: 14, fontWeight: FontWeight.w100, fontColor: AppColors.Black),
          ),
        ),
      ],
    );
  }
}
