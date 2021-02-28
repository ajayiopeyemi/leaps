import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaps/core/components/leaps_custom_clipper.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/explore/presentation/widgets/new_search_card_view.dart';
import 'package:leaps/features/notes/presentation/widgets/view_suggested_note_plan.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Purple,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: LeapsCustomShapeClipper(),
              child: Container(
                height: AppDimensions.screenHeight(context) * 0.35,
                decoration: BoxDecoration(color: AppColors.Purple),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Howdy, ',
                                    style: bodyStyle(fontColor: AppColors.White),
                                  ),
                                  TextSpan(
                                    text: '${AppState.userDetails.firstName}',
                                    style: headerStyle(textColor: AppColors.White, fontSize: 16.0).copyWith(
                                        letterSpacing: 1.0
                                    ),
                                  ),
                                ]
                            )
                        ),
                        Spacer(),
                        AppState.userDetails.avatar == null || AppState.userDetails.avatar.isEmpty
                            ? SvgPicture.asset(
                          AppSVGs.user,
                          color: AppColors.White,
                          width: 25,
                          height: 25,
                        )
                            : CachedNetworkImage(
                            imageUrl: AppState.userDetails.avatar,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 40,
                              height: 40,
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
                                child: LeapsLoadIndicator.loadingPulse(25.0))),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Discover contents',
                                style: bodyStyle(fontColor: AppColors.White, fontSize: 18.0, fontWeight: FontWeight.w200),
                              ),
                              TextSpan(
                                text: '\nFor your students',
                                style: headerStyle(textColor: AppColors.White, fontSize: 24.0,).copyWith(
                                    letterSpacing: 1.0
                                ),
                              ),
                            ]
                        )
                    ),
                  ),
                  AppDimensions.verticalSpacer(spaceSize: 35.0),
                  NewSearchCardView(),
                  AppDimensions.verticalSpacer(spaceSize: 35.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: NewSuggestedLessonPlanView(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
