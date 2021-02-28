import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaps/core/components/leaps_container.dart';
import 'package:leaps/core/components/leaps_custom_clipper.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';

import 'student_lesson_plan_pages.dart';

class StudentNoteScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: LeapsCustomShapeClipper(),
              child: Container(
                height: AppDimensions.screenHeight(context) / 4,
                decoration: BoxDecoration(color: AppColors.Purple,),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: AppDimensions.screenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppDimensions.verticalSpacer(spaceSize: 4.0),
                    Row(
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hi,\n',
                                    style: bodyStyle(
                                      fontSize: 20,
                                      fontColor: AppColors.White,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${AppState.userDetails.firstName}',
                                    style: bodyStyle(
                                        fontSize: 20,
                                        fontColor: AppColors.White,
                                        fontWeight: FontWeight.w500
                                    ).copyWith(
                                      letterSpacing: 1.3,
                                      height: 1.3
                                    ),
                                  ),
                                ]
                            )
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                          child: AppState.userDetails.avatar == null || AppState.userDetails.avatar.isEmpty ?
                          SvgPicture.asset(
                            AppSVGs.user,
                            color: AppColors.White,
                            width: 25,
                            height: 25,
                          ):
                          CachedNetworkImage(
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
                        ),
                      ],
                    ),
                    Divider(),
                    Text(
                      "Hope school was\nfun today!",
                      style: headerStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.White
                      ),
                    ),
                    AppDimensions.verticalSpacer(spaceSize: AppDimensions.screenHeight(context) * 0.1),
                    Text(
                      "Please select a study subject",
                      style: bodyStyle(
                          fontColor: AppColors.Black
                      ),
                    ),
                    AppDimensions.verticalSpacer(spaceSize: 18.0),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      _openLessonPlanPage(context, StudentLessonPlan(subjects[0]));
                                    },
                                      child: CardWithIllustration(AppImages.integrated_science, subjects[0], 7)
                                  )
                                ),
                                AppDimensions.horizontalSpacer(spaceSize: 12.0),
                                Expanded(
                                    child: InkWell(
                                        onTap: (){
                                          _openLessonPlanPage(context, StudentLessonPlan(subjects[1]));
                                        },
                                        child: CardWithIllustration(AppImages.civic_studies, subjects[1], 7)
                                    )
                                )
                              ],
                            ),
                          ),
                          AppDimensions.verticalSpacer(spaceSize: 24.0),
                          InkWell(
                              onTap: (){
                                _openLessonPlanPage(context, StudentLessonPlan(subjects[2]));
                              },
                              child: CardWithIllustration(AppImages.education, subjects[2], 4)
                          ),
                          AppDimensions.verticalSpacer(spaceSize: 24.0),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWithIllustration extends StatelessWidget{
  final String illustration, text;
  final int height;
  CardWithIllustration(this.illustration, this.text, this.height);
  @override
  Widget build(BuildContext context) {
    return LeapsContainer(
      color: AppColors.White,
      shadowColor: AppColors.PrimaryColor,
      borderRadius: 8.0,
      child: Column(
        children: <Widget>[
          Container(
            height: AppDimensions.screenHeight(context) / height,
            width: AppDimensions.screenWidth(context),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: FittedBox(
                child: Image.asset(illustration),
                fit: BoxFit.fill,
              )
            ),
          ),
          AppDimensions.verticalSpacer(spaceSize: 12.0),
          Text(
            text,
            style: bodyStyle(
                fontColor: AppColors.Black
            ),
          ),
          AppDimensions.verticalSpacer(spaceSize: 12.0),
        ],
      ),
    );
  }
}

void _openLessonPlanPage(BuildContext context, Widget child) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => child,
          fullscreenDialog: true
      )
  );
}