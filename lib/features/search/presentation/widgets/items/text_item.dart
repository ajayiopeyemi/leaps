import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/resource.dart';

class TextItem extends StatelessWidget {
  final Resource resource;
  final Color color;
  TextItem({this.resource, this.color});

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

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
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text('${resource.heading}', style: headerStyle()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: new Text(
                        '${resource.excerpt}',
                        style: bodyStyle(
                            fontWeight: FontWeight.w400,
                            fontColor: AppColors.Black
                        ).copyWith(
                            letterSpacing: 1.0,
                            height: 1.8
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
