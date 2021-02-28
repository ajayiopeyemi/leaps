import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/resource.dart';

class VideoItem extends StatelessWidget {
  final Resource resource;
  const VideoItem({this.resource});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
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
            child: Container(
              height: AppDimensions.screenHeight(context),
              color: AppColors.OffWhiteThick,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      AppSVGs.play_button,
                      color: AppColors.Red,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        '${resource.title}',
                        maxLines: 1,
                        style: bodyStyle(fontColor: AppColors.Black),
                        overflow: TextOverflow.ellipsis,
                      ),
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
