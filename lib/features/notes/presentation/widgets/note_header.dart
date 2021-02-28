import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/notes/data/model/note.dart';

class NoteHeader extends StatelessWidget {
  final Note note;
  NoteHeader({@required this.note}) : assert(note != null);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: AppColors.White.withOpacity(0.5)),
                child: LeapsAssetWithText(
                  isHorizontal: true,
                  hPadding: 0.0,
                  isIcon: false,
                  text: note.subject,
                  textStyle: bodyStyle(
                    fontColor: AppColors.Purple,
                    fontSize: AppDimensions.dimenTwelve,
                  ),
                  svg: AppSVGs.subjectsIcons[note.subjectIndex],
                  iconSize: 18.0,
                  iconColor: AppColors.Purple,
                ),
              ),
            ),
            SizedBox(height: 70),
            Expanded(
              child: Text(
                /*note.topic + note.topic + note.topic + note.topic,*/
                note.topic,
                style: bodyStyle(
                    fontColor: AppColors.White,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  '${note.ownerSchool}',
                  style: bodyStyle(
                      fontColor: AppColors.White,
                      fontWeight: FontWeight.w300),
                ),
                Spacer(),
                LeapsAssetWithText(
                  isIcon: true,
                  isHorizontal: true,
                  text: '${note.duration} Weeks',
                  textStyle: bodyStyle(fontColor: AppColors.White),
                  iconData: Icons.timelapse,
                  iconColor: AppColors.White,
                  iconSize: 16.0,
                  customSpacer: 4.0,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: new ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.White,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.Purple.withOpacity(0.5)),
                  value: 0.9,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
