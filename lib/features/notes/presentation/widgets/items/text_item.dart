import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:provider/provider.dart';

class TextItem extends StatelessWidget {
  final int index;
  TextItem({this.index});

  @override
  Widget build(BuildContext context) {
    var resource = Provider.of<List<Resource>>(context);

    return new LayoutBuilder(
      builder: (context, constraint) {

        return new Container(
          margin: const EdgeInsets.only(
              top: 8.0, right: 10.0, left: 4.0, bottom: 8.0),
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
              width: MediaQuery.of(context).size.width / 1.9,
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(
                    resource[index].heading,
                    style: headerStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: new Text(
                        resource[index].definition,
                        style: bodyStyle(fontColor: AppColors.Black),
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
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
