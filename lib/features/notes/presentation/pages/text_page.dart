import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/features/notes/presentation/pages/note_text_preview.dart' as NoteTextPreview;
import 'package:leaps/features/notes/presentation/widgets/empty_week_view.dart';
import 'package:leaps/features/notes/presentation/widgets/items/text_item.dart';
import 'package:leaps/features/notes/presentation/widgets/note_week_header.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/domain/viewmodels/resources_viewmodel.dart';
import 'package:provider/provider.dart';

class TextPage extends StatelessWidget {
  final String docId;
  TextPage({
    @required this.docId,
  }) : assert(docId != null);

  @override
  Widget build(BuildContext context) {
    print('The doc id is: $docId');
    return LayoutBuilder(
      builder: (context, constraint) {
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              height: MediaQuery.of(context).size.height / 1.7,
              child: Column(
                children: <Widget>[
                  WeekHeader('Week 1', 8.0),
                  Expanded(
                    child: BaseChangeNotifierProvider<ResourcesViewModel>(
                      model: ResourcesViewModel(
                          resourceServices: Provider.of(context)),
                      builder: (_, model, child) =>
                      StreamProvider<List<Resource>>.value(
                        value: model.getResourcesInWeek1(
                            docId, '${ApiConstants.textRoute}s'),
                        child: WeekViewBuilder(),
                      ),
                    ),
                  ),
                  WeekHeader('Week 2', 16.0),
                  Expanded(
                    child: BaseChangeNotifierProvider<ResourcesViewModel>(
                      model: ResourcesViewModel(
                          resourceServices: Provider.of(context)),
                      builder: (_, model, child) => StreamProvider<List<Resource>>.value(
                        value: model.getResourcesInWeek2(docId, '${ApiConstants.textRoute}s'),
                        child: WeekViewBuilder(),
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

class WeekViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var resource = Provider.of<List<Resource>>(context);
    if (resource == null) {
      return LeapsLoadIndicator.loadingFadingCircle(40.0);
    }
    switch (resource.length) {
      case 0:
        return EmptyWeekView();
      default:
        return ListView.builder(
            itemCount: resource.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NoteTextPreview.TextPreview(
                              resource: resource[index], isForLessonNote: true),
                          fullscreenDialog: true,
                        ));
                  },
                  child: TextItem(index: index));
            });
    }
  }
}
