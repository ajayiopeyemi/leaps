import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/presentation/widgets/resource_status.dart';

class ImagePreview extends StatelessWidget {
  final Resource resource;
  final bool isForLessonNote;
  ImagePreview({@required this.resource, @required this.isForLessonNote})
      : assert(resource != null);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: Container(
            width: AppDimensions.screenWidth(context),
            child: CachedNetworkImage(
                imageUrl: resource.filePath,
                fit: BoxFit.cover,
                fadeInDuration: Duration(microseconds: 500),
                fadeInCurve: Curves.easeIn,
                placeholder: (context, url) => Center(
                      child: SpinKitDoubleBounce(
                        color: AppColors.White.withOpacity(0.5),
                        size: 25,
                      ),
                    )),
          ),
        ),
        Visibility(
          visible: isForLessonNote == true ? false : true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    resource.title ?? "",
                    style: TextStyle(fontWeight: FontWeight.w100),
                  ),
                ),
                Divider(),
                ResourceStatusWidget(resource: resource)
              ],
            ),
          ),
        )
      ],
    );
  }
}
