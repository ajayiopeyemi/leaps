import 'package:flutter/material.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';

class EmptySuggestedLessonPlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppDimensions.verticalSpacer(spaceSize: 32.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppImages.NoSearchResult,
                    ),
                    fit: BoxFit.cover)),
          )
        ),
        SizedBox(
          height: 24.0,
        ),
        Expanded(
          child: Text(
            "Looks like no teacher(s) in ${AppState.userDetails.country} have created lesson plans yet\nKindly check back",
            textAlign: TextAlign.center,
            style:
            bodyStyle(fontSize: 14, fontWeight: FontWeight.w100, fontColor: AppColors.Black),
          ),
        ),
      ],
    );
  }
}
