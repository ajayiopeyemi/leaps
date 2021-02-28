import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:provider/provider.dart';

class PdfItem extends StatelessWidget {
  final int index;
  PdfItem({this.index});
  @override
  Widget build(BuildContext context) {
    var resources = Provider.of<List<Resource>>(context);
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
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: width,
                      color: AppColors.Red,
                      child: Center(
                        child: new Text(
                          'PDF',
                          style: TextStyle(
                              color: AppColors.White,
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: new Container(
                      width: width,
                      color: AppColors.White,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Text(
                            '${resources[index].title}',
                            style: TextStyle(color: AppColors.Black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
