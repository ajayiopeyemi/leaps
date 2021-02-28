import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/resource.dart';

class ImageItem extends StatelessWidget {
  final Resource resource;
  final bool isForLessonNote;
  ImageItem({
    this.resource,
    this.isForLessonNote
  });

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              isForLessonNote == null ?
              CachedNetworkImage(
                  imageUrl: '${resource.filePath}',
                  fit: BoxFit.fill,
                  fadeInDuration: Duration(microseconds: 500),
                  fadeInCurve: Curves.easeIn,
                  placeholder: (context, url) => Center(
                    child: SpinKitDoubleBounce(
                      color: AppColors.White.withOpacity(0.5),
                      size: 25,
                    ),
                  )
              ):
              Container(
                height: AppDimensions.screenHeight(context) * 0.15,
                width: AppDimensions.screenWidth(context),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedNetworkImage(
                      imageUrl: '${resource.filePath}',
                      fadeInDuration: Duration(microseconds: 500),
                      fadeInCurve: Curves.easeIn,
                      placeholder: (context, url) => Center(
                            child: SpinKitDoubleBounce(
                              color: AppColors.White.withOpacity(0.5),
                              size: 25,
                            ),
                          )
                  ),
                ),
              ),
              Divider(),
              isForLessonNote == null ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  '${resource.title}',
                  style: bodyStyle(
                    fontColor: AppColors.Black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ):
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${resource.title}',
                    style: bodyStyle(
                      fontColor: AppColors.Black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
