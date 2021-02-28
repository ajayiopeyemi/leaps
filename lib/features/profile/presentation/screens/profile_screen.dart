import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/components/leaps_container.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/authentication/presentation/helpers/leaps_auth_helper.dart';
import 'package:leaps/features/profile/presentation/helper/profile_screen_helper.dart';

import '../widgets/profile_screen_item.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = AppState.userDetails;
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: AppDimensions.screenHeight(context),
              child: Column(
                children: <Widget>[
                  LeapsContainer(
                    color: AppColors.White,
                    shadowColor: AppColors.Purple,
                    padding: 0.0,
                    borderRadius: 8.0,
                    margin: 20.0,
                    child: new Column(
                      children: <Widget>[
                        AppDimensions.verticalSpacer(spaceSize: 20.0),
                        GestureDetector(
                            onTap: () {
                              chooseAvatar(context);
                              /*LeapsDialogs.bottomModalSheet(
                              context,
                              ImageSourceSelector()
                          );*/
                            },
                            child: user.avatar != null && user.avatar.isNotEmpty
                                ? CachedNetworkImage(
                                imageUrl: user.avatar,
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 60,
                                  height: 60,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                fadeInDuration: Duration(microseconds: 500),
                                fadeInCurve: Curves.easeIn,
                                placeholder: (context, url) => Center(
                                    child: LeapsLoadIndicator.loadingPulse(25.0)))
                                : Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppSVGs.user,
                                  color: AppColors.Black,
                                  width:
                                  AppDimensions.screenWidth(context) * 0.15,
                                  height:
                                  AppDimensions.screenWidth(context) * 0.15,
                                ),
                                AppDimensions.verticalSpacer(),
                                Text(
                                  'Tap to change',
                                  style: bodyStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.0),
                                ),
                              ],
                            )),
                        AppDimensions.verticalSpacer(spaceSize: 20.0),
                        Text(
                          '${user.firstName ?? ''} ${user.surname ?? ''}',
                          style: TextStyle(
                              color: AppColors.Black,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.dimenTwenty),
                        ),
                        AppDimensions.verticalSpacer(),
                        Text('${user.email}'),
                        AppDimensions.verticalSpacer(spaceSize: 10.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            LeapsAssetWithText(
                              isHorizontal: true,
                              isIcon: true,
                              text: '${user.schoolName}',
                              textStyle: bodyStyle(
                                  fontColor: AppColors.PrimaryColor,
                                  fontSize: AppDimensions.dimenTwelve),
                              iconData: Icons.school,
                              iconColor: AppColors.Yellow,
                              iconSize: AppDimensions.dimenEighteen,
                              hPadding: 0.0,
                            ),
                            Visibility(
                              visible: user.isStudent == true ? true : false,
                              child: LeapsAssetWithText(
                                isHorizontal: true,
                                isIcon: true,
                                text: '${user.className}',
                                textStyle: bodyStyle(
                                    fontColor: AppColors.PrimaryColor,
                                    fontSize: AppDimensions.dimenTwelve),
                                iconData: Icons.class_,
                                iconColor: AppColors.Purple,
                                iconSize: AppDimensions.dimenEighteen,
                                hPadding: 16.0,
                              ),
                            )
                          ],
                        ),
                        AppDimensions.verticalSpacer(spaceSize: 10.0),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: <Widget>[
                          ProfileScreenItem('Change Password', AppSVGs.unlocked,
                                  () => LeapsAuthHelper.showResetPasswordDialog(context)),
                          ProfileScreenItem(
                              'About Leaps', AppSVGs.about, () => launchURL()),
                          LeapsButton(
                            marginTop: AppDimensions.dimenThirtyTwo,
                            textColor: AppColors.White,
                            btnText: 'Log Out',
                            btnBak: AppColors.Red,
                            onPressed: () => LeapsAuthHelper.confirmSignOut(context),
                            btnWidth: AppDimensions.screenWidth(context) / 2,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
