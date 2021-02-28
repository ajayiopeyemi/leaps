import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';

class LessonNoteEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDetails = AppState.userDetails;
    String teacherDescription =
        'Looks like your lesson plan is empty.\nClick the button below to create one';
    String studentDescription =
        "Looks like your teacher don't have a lesson plan for you yet. Check back later";
    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (context, constraint) {
          var viewHeight = constraint.maxHeight;
          var viewWidth = constraint.maxHeight;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: SvgPicture.asset(
                      AppSVGs.Empty,
                      width: viewWidth / 3,
                      height: viewHeight / 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppString.Oops,
                      textAlign: TextAlign.center,
                      style: headerStyle(
                          fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      userDetails.isStudent == false
                          ? teacherDescription
                          : studentDescription,
                      textAlign: TextAlign.center,
                      style:
                          bodyStyle(fontSize: 14, fontWeight: FontWeight.w300).copyWith(height: 1.5),
                    ),
                  ),
                  /*Visibility(
                    visible: userDetails.isStudent == false ? true : false,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        alignment: Alignment.center,
                        child: RaisedButton.icon(
                          color: AppColors.Purple,
                          onPressed: () {
                            LeapsDialogs.simpleDialog(
                                context, NewLessonPlanForm());
                          },
                          icon: Icon(
                            Icons.add,
                            color: AppColors.White,
                          ),
                          label: Text(
                            'Create Lesson Plan',
                            style: bodyStyle(fontColor: AppColors.White),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                  )*/
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
