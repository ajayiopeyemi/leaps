import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/components/leaps_choice_chip.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/data/services/note_service.dart';
import 'package:leaps/features/notes/presentation/screens/lesson_note_screen.dart';
import 'package:provider/provider.dart';

class NotePlanItem extends StatelessWidget {
  final int index;
  NotePlanItem({this.index});

  @override
  Widget build(BuildContext context) {
    var value = planActions.asMap();
    var notePlan = Provider.of<List<Note>>(context);
    var noteService = Provider.of<NoteService>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonNote(
                      note: notePlan[index],
                    ),
                fullscreenDialog: true));
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return new Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
            color: AppColors.White,
            boxShadow: [
              BoxShadow(
                  color: AppColors.Background.withOpacity(0.9), blurRadius: 9),
            ],
          ),
          child: new ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(notePlan[index].topic,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: headerStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Visibility(
                        visible: AppState.userDetails.isStudent == true ? false : true,
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          iconSize: 20.0,
                          isExpanded: false,
                          icon: Icon(Icons.more_vert, color: AppColors.Black),
                          items: [
                            DropdownMenuItem<String>(
                              value: notePlan[index].isApproved == true
                                  ? value[0]
                                  : value[1],
                              child: Text(notePlan[index].isApproved == true
                                  ? value[0]
                                  : value[1]),
                            ),
                            DropdownMenuItem<String>(
                              value: value[2],
                              child: Text(value[2]),
                            ),
                          ],
                          /*items: planActions.map((dropDownStringItem){
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),*/
                          onChanged: (returnValue) {
                            if (returnValue == value[0] ||
                                returnValue == value[1]) {
                              Map<String, dynamic> dataToMap() {
                                var map = new Map<String, dynamic>();
                                map[NotePlanConstants.IS_APPROVED] =
                                    !notePlan[index].isApproved;
                                return map;
                              }

                              noteService.approveLessonPlan(
                                  notePlan[index].docId, dataToMap());
                              print(value[0]);
                            } else {
                              noteService.deleteLessonPlan(notePlan[index].docId);
                              print(value[1]);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: AppColors
                          .subjectsColors[notePlan[index].subjectIndex]
                          .withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.dimenEight),
                      child: LeapsAssetWithText(
                        isHorizontal: true,
                        hPadding: 0.0,
                        isIcon: false,
                        text: notePlan[index].subject,
                        textStyle: bodyStyle(
                          fontColor: AppColors
                              .subjectsColors[notePlan[index].subjectIndex],
                          fontSize: AppDimensions.dimenTwelve,
                        ),
                        svg:
                            AppSVGs.subjectsIcons[notePlan[index].subjectIndex],
                        iconColor: AppColors
                            .subjectsColors[notePlan[index].subjectIndex],
                        iconSize: 20,
                      ),
                    ),
                  ),
                  Divider(),
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: AppDimensions.screenWidth(context),
                      child: Row(
                        children: <Widget>[
                          LeapsChoiceChips(
                            icon: Icons.speaker_notes,
                            text: '${notePlan[index].noOfTextDocs}',
                            iconColor: AppColors.Green,
                          ),
                          LeapsChoiceChips(
                              icon: Icons.picture_as_pdf,
                              text: '${notePlan[index].noOfPdfDocs}',
                              iconColor: AppColors.Red),
                          LeapsChoiceChips(
                              icon: Icons.image,
                              text: '${notePlan[index].noOfImages}',
                              iconColor: AppColors.Yellow),
                          LeapsChoiceChips(
                              icon: Icons.movie,
                              text: '${notePlan[index].noOfVideos}',
                              iconColor: AppColors.Purple),
                          Spacer(),
                          Visibility(
                            visible:  AppState.userDetails.isStudent == true ? false : true,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                                decoration: BoxDecoration(
                                    color: notePlan[index].isApproved == true ? AppColors.Green : AppColors.Red ,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Text(
                                  notePlan[index].isApproved == true ? 'Approved' : 'Pending',
                                  style: bodyStyle(fontColor: AppColors.White, fontSize: 12.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      }),
    );
  }
}
