import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/authentication/presentation/helpers/leaps_auth_helper.dart';

class ResearcherOnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: AppDimensions.screenHeight(context),
        padding: AppEdgeInsets.allEight,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                AppDimensions.verticalSpacer(
                    spaceSize: AppDimensions.dimenThirtyTwo),
                Text(
                  AppString.Oops,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: LeapsButton(
                marginTop: 8.0,
                textColor: AppColors.White,
                btnText: 'Logout',
                btnBak: AppColors.Purple,
                btnWidth: AppDimensions.screenWidth(context) * 0.8,
                onPressed: () {
                  LeapsAuthHelper.confirmSignOut(context);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
