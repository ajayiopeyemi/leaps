import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/resource.dart';

class NewPdfItem extends StatelessWidget {
  final Resource resource;
  final Color color;
  const NewPdfItem({this.resource, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.screenWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
        color: AppColors.White,
        boxShadow: [
          BoxShadow(
              color: AppColors.Background.withOpacity(0.9), blurRadius: 9),
        ],
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            AppSVGs.pdf,
            width: 30,
            height: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new Text(
                  '${resource.title}.pdf',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: bodyStyle(
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.Black
                  ).copyWith(
                    letterSpacing: 1.0,
                    height: 1.8,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
