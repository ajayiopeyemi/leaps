import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

import '../../widgets/mock_of_stepper.dart';


class NewSignUpScreen extends StatelessWidget {
  final String pageTitle;
  final int pageIndex;
  final Widget page;
  final bool isStudent;
  NewSignUpScreen({
    @required this.pageTitle,
    @required this.pageIndex,
    @required this.page,
    @required this.isStudent
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Background,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Color(0xFFE8E6E9),
        body: LayoutBuilder(
          builder: (context, constraint) {
            final height = constraint.maxHeight;
            final width = constraint.maxWidth;

            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                    top: height * 0.30,
                    child: new RotationTransition(
                      turns: new AlwaysStoppedAnimation(365 / 360),
                      child: Image.asset(
                        AppImages.PencilAsset,
                        width: width,
                        height: height,
                      ),
                    )
                ),
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
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      MockOfStepper(pageIndex: pageIndex, isStudent: isStudent),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        pageTitle,
                        style: headerStyle(
                            fontSize: 50.0
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      page
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
