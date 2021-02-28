import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class SearchErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppDimensions.verticalSpacer(spaceSize: 16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
                AppSVGs.server_down
            ),
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Expanded(
          child: Text(
            'An error occued\nThis may be you internt, kindly check and try again',
            textAlign: TextAlign.center,
            style:
            bodyStyle(fontSize: 14, fontWeight: FontWeight.w100, fontColor: AppColors.Black),
          ),
        ),
      ],
    );
  }
}
