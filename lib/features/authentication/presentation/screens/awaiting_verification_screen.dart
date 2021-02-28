import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/authentication/presentation/helpers/leaps_auth_helper.dart';
import 'package:leaps/features/notes/presentation/z_teachers/suggested_lesson_plan_screen.dart';

class AwaitingVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: AppDimensions.screenHeight(context),
              padding: AppEdgeInsets.allEight,
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      AppDimensions.verticalSpacer(
                          spaceSize: AppDimensions.dimenThirtyTwo),
                      Text(
                        'Awaiting verification',
                        style: headerStyle(),
                      ),
                      Image.asset(
                        AppImages.Verifying,
                        fit: BoxFit.fitHeight,
                        height: AppDimensions.screenHeight(context) * 0.45,
                      ),
                      Text(
                        AppString.VERIFICATION_DESCRIPTION,
                        textAlign: TextAlign.center,
                        style: bodyStyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      LeapsButton(
                        marginTop: 8.0,
                        textColor: AppColors.White,
                        btnText: "See other teacher's lesson note",
                        btnBak: AppColors.Purple,
                        btnWidth: AppDimensions.screenWidth(context) * 0.8,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SuggestedTopicForUnverifiedUser()));
                        },
                      ),
                      AppDimensions.verticalSpacer(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('OR'),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: AppDimensions.screenWidth(context) * 0.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.dimenSixteen),
                        child: FlatButton(
                          padding: AppEdgeInsets.allSixteen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side:
                              BorderSide(color: AppColors.Purple, width: 1.0)),
                          color: AppColors.OffWhite,
                          child: Text('Logout'),
                          onPressed: () {
                            LeapsAuthHelper.confirmSignOut(context);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class SuggestedTopicForUnverifiedUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Purple,
        title: Text('Suggested lesson note'),
        elevation: 0.0,
      ),
      body: SuggestedLessonPlan(),
    );
  }
}
