import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/components/leaps_container.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:provider/provider.dart';

import '../helpers/auth_notifier.dart';
import 'forms/personal_details_form.dart';
import 'sign_in_screen.dart';

class JoinUsScreen extends StatefulWidget {
  @override
  _JoinUsScreenState createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Background,
        statusBarIconBrightness: Brightness.dark));

    return SafeArea(
      top: true,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraint) {
            final height = constraint.maxHeight;
            final width = constraint.maxWidth;

            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color: AppColors.Background,
                ),
                Positioned(
                    left: -(width * 0.15),
                    bottom: height * 0.03,
                    child: new RotationTransition(
                      turns: new AlwaysStoppedAnimation(90 / 360),
                      child: Image.asset(
                        AppImages.PencilAsset,
                        width: width,
                        height: height,
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.Logo,
                    width: width * 0.8,
                    height: width * 0.8,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: AppDimensions.dimenTwenty),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Sign up as',
                        style: bodyStyle(
                            fontSize: 20.0, fontColor: AppColors.Black),
                      ),
                      AppDimensions.verticalSpacer(spaceSize: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: LeapsContainer(
                                color: AppColors.Purple,
                                shadowColor: AppColors.Black,
                                borderRadius: 8.0,
                                child: FlatButton.icon(
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0)),
                                  padding: EdgeInsets.all(4.0),
                                  color: AppColors.Purple,
                                  onPressed: () {
                                    Provider.of<AuthNotifier>(context, listen: false).setCountry(null);
                                    Provider.of<AuthNotifier>(context).setShouldCountryNameShow(value: false);
                                    LeapsAppNavigator(
                                      context: context,
                                        page: PersonalDetailsForm(isTeacher: false,)
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    AppSVGs.student,
                                    width: 30.0,
                                    height: 30.0,
                                    color: AppColors.White,
                                  ),
                                  label: Flexible(
                                    child: Text(
                                      'Student',
                                      style: bodyStyle(
                                        fontColor: AppColors.White,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: LeapsContainer(
                                color: AppColors.Purple,
                                shadowColor: AppColors.Black,
                                borderRadius: 8.0,
                                child: FlatButton.icon(
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0)),
                                  padding: EdgeInsets.all(4.0),
                                  color: AppColors.Purple,
                                  onPressed: () {
                                    Provider.of<AuthNotifier>(context, listen: false).setCountry(null);
                                    Provider.of<AuthNotifier>(context).setShouldCountryNameShow(value: false);
                                    LeapsAppNavigator(
                                        context: context,
                                        page: PersonalDetailsForm(
                                          isTeacher: true,
                                        )
                                    );
                                  },

                                  icon: SvgPicture.asset(
                                    AppSVGs.teacher,
                                    width: 30.0,
                                    height: 30.0,
                                    color: AppColors.White,
                                  ),
                                  label: Flexible(
                                    child: Text(
                                      'Teacher',
                                      style: bodyStyle(
                                        fontColor: AppColors.White,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.dimenTwentyFour),
                        child: Row(
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
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.dimenTwentyFour),
                        width: width,
                        child: LeapsButton(
                          btnBak: AppColors.White,
                          btnWidth: 50.0,
                          btnText: 'Login',
                          textColor: AppColors.Black,
                          marginTop: AppDimensions.dimenSixteen,
                          onPressed: () {
                            LeapsAppNavigator(
                                context: context,
                                page: SignInScreen()
                            );
                          },
                        ),
                      ),
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
