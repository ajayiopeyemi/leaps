import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_app_bar_style.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/authentication/presentation/screens/forms/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Background,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: leapsPrimaryAppBar(
            title: 'Sign In', appBarBak: AppColors.Background),
        body: LayoutBuilder(
          builder: (context, constraint) {
            final height = constraint.maxHeight;
            final width = constraint.maxWidth;

            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color: Color(0xFFE8E6E9),
                ),
                Positioned(
                    right: -(width * 0.13),
                    child: new RotationTransition(
                      turns: new AlwaysStoppedAnimation(270 / 360),
                      child: Image.asset(
                        AppImages.PencilAsset,
                        width: width,
                        height: height,
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    AppImages.Logo,
                    width: width * 0.3,
                    height: width * 0.3,
                  ),
                ),
                Container(
                  padding: AppEdgeInsets.allTwentyFour,
                  color: AppColors.Background.withOpacity(0.3),
                  child: ListView(
                    children: <Widget>[
                      SvgPicture.asset(
                        AppSVGs.BookLover,
                        width: width * 0.2,
                        height: height * 0.2,
                      ),
                      SignInForm(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
