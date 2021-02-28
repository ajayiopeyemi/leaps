import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/presentation/screens/lesson_note_screen.dart';

class SuggestedLessonPlanItemCard extends StatelessWidget {
  final Note note;
  SuggestedLessonPlanItemCard({
    @required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LessonNote(note: note),
                    fullscreenDialog: true));
          },
          child: new Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              color: AppColors.White,
              boxShadow: [
                BoxShadow(
                    color: AppColors.Background.withOpacity(0.9),
                    blurRadius: 9),
              ],
            ),
            child: new ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.dimenTwelve,
                          horizontal: AppDimensions.dimenSix),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: AppEdgeInsets.allEight,
                            padding: AppEdgeInsets.allEight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.subjectsColors[note.subjectIndex]
                                  .withOpacity(0.2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppSVGs.subjectsIcons[note.subjectIndex],
                                  width: 20.0,
                                  height: 20.0,
                                  color: AppColors
                                      .subjectsColors[note.subjectIndex],
                                ),
                                AppDimensions.horizontalSpacer(spaceSize: 0.0),
                                Expanded(
                                  child: Text(
                                    '${note.subject}',
                                    textAlign: TextAlign.center,
                                    style: bodyStyle(
                                      fontSize: AppDimensions.dimenTwelve,
                                      fontColor: AppColors
                                          .subjectsColors[note.subjectIndex],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              note.topic,
                              textAlign: TextAlign.center,
                              style: headerStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                      color: AppColors.White,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.Background.withOpacity(1),
                            blurRadius: 9),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            LeapsAssetWithText(
                              isHorizontal: true,
                              isIcon: true,
                              customSpacer: 1.0,
                              text: '${note.noOfTextDocs}',
                              textStyle: bodyStyle(
                                  fontColor: AppColors.PrimaryColor,
                                  fontSize: AppDimensions.dimenTwelve),
                              iconData: Icons.speaker_notes,
                              iconColor: AppColors.Green,
                              iconSize: AppDimensions.dimenEighteen,
                            ),
                            Spacer(),
                            LeapsAssetWithText(
                              isHorizontal: true,
                              isIcon: true,
                              hPadding: 8.0,
                              customSpacer: 1.0,
                              text: '${note.noOfPdfDocs}',
                              textStyle: bodyStyle(
                                  fontColor: AppColors.PrimaryColor,
                                  fontSize: AppDimensions.dimenTwelve),
                              iconData: Icons.picture_as_pdf,
                              iconColor: AppColors.Red,
                              iconSize: AppDimensions.dimenEighteen,
                            ),
                          ],
                        ),
                        SizedBox(height: AppDimensions.dimenSix),
                        Row(
                          children: <Widget>[
                            LeapsAssetWithText(
                              isHorizontal: true,
                              isIcon: true,
                              customSpacer: 1.0,
                              text: '${note.noOfImages}',
                              textStyle: bodyStyle(
                                  fontColor: AppColors.PrimaryColor,
                                  fontSize: AppDimensions.dimenTwelve),
                              iconData: Icons.image,
                              iconColor: AppColors.Yellow,
                              iconSize: AppDimensions.dimenEighteen,
                            ),
                            Spacer(),
                            LeapsAssetWithText(
                              isHorizontal: true,
                              isIcon: true,
                              customSpacer: 1.0,
                              hPadding: 8.0,
                              text: '${note.noOfVideos}',
                              textStyle: bodyStyle(
                                  fontColor: AppColors.PrimaryColor,
                                  fontSize: AppDimensions.dimenTwelve),
                              iconData: Icons.movie,
                              iconColor: AppColors.Purple,
                              iconSize: AppDimensions.dimenEighteen,
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            note.ownerImg == null || note.ownerImg.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: AppDimensions.dimenSixteen,
                                        right: AppDimensions.dimenFour),
                                    child: SvgPicture.asset(
                                      AppSVGs.user,
                                      color: AppColors.PrimaryColor,
                                      width: 12,
                                      height: 12,
                                    ))
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: AppDimensions.dimenSixteen,
                                        right: AppDimensions.dimenFour),
                                    child: CachedNetworkImage(
                                        imageUrl: note.ownerImg,
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: 14,
                                          height: 14,
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppDimensions.dimenSixteen,
                                    horizontal: 4.0),
                                child: Text(
                                  'by ${note.owner}.' ?? '',
                                  style: bodyStyle(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
