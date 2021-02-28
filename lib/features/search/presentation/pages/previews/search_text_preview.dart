import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/presentation/widgets/resource_status.dart';

class TextPreview extends StatelessWidget {
  final Resource resource;
  final bool isForLessonNote;
  TextPreview({@required this.resource, @required this.isForLessonNote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          height: constraint.maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(resource.heading, style: headerStyle()),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        "${resource.definition}",
                        style: bodyStyle(
                          fontWeight: FontWeight.w400,
                          fontColor: AppColors.Black
                        ).copyWith(
                          letterSpacing: 1.0,
                          height: 2.0
                        )
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isForLessonNote == true ? false : true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(),
                    ResourceStatusWidget(resource: resource)
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
