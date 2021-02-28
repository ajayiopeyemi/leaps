import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/components/leaps_container.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/notes/presentation/z_teachers/suggested_lesson_plan_screen.dart';

class NewSuggestedLessonPlanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LeapsContainer(
      color: AppColors.White,
      borderRadius: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              AppSVGs.suggested_teacher,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Care to see lesson plans other teachers in ${AppState.userDetails.country} have created ?',
              textAlign: TextAlign.center,
              style: bodyStyle(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: LeapsButton(
                  btnBak: AppColors.Purple,
                  textColor: AppColors.White,
                  btnText: 'View',
                  marginTop: 24.0,
                onPressed: (){
                    LeapsAppNavigator(
                      context: context,
                      page: SuggestedLessonPlanForHomeScreen(),
                      transitionType: TransitionType.Slide
                    );
                },
              ),
            )
          ],
        ),
      ),
      shadowColor: AppColors.Purple,
    );
  }
}

class SuggestedLessonPlanForHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Purple,
        title: Text('Suggested lesson plans'),
        elevation: 0.0,
      ),
      body: SuggestedLessonPlan(),
    );
  }
}
