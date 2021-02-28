import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/features/notes/presentation/modals/note_video_preview.dart' as NoteVideoPreview;
import 'package:leaps/features/notes/presentation/widgets/empty_week_view.dart';
import 'package:leaps/features/notes/presentation/widgets/items/video_item.dart';
import 'package:leaps/features/notes/presentation/widgets/note_week_header.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/domain/viewmodels/resources_viewmodel.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatelessWidget {
  final String docId;
  VideoPage({@required this.docId}) : assert(docId != null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              WeekHeader('Week 1', 0.0),
              Container(
                  height: 150,
                  child: BaseChangeNotifierProvider<ResourcesViewModel>(
                    model: ResourcesViewModel(
                        resourceServices: Provider.of(context)),
                    builder: (_, model, child) =>
                        StreamProvider<List<Resource>>.value(
                      value: model.getResourcesInWeek1(
                          docId, '${ApiConstants.videosRoute}'),
                      child: WeekViewBuilder(),
                    ),
                  )),
              WeekHeader('Week 2', 24.0),
              Container(
                  height: 150,
                  child: BaseChangeNotifierProvider<ResourcesViewModel>(
                    model: ResourcesViewModel(
                        resourceServices: Provider.of(context)),
                    builder: (_, model, child) => StreamProvider<List<Resource>>.value(
                      value: model.getResourcesInWeek2(docId, '${ApiConstants.videosRoute}'),
                      child: WeekViewBuilder(),
                    ),
                  )),
            ],
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
                    LeapsDialogs.simpleDialog(
                        context,
                        NoteVideoPreview.VideoPreview(
                          resource: resource[index],
                          isForLessonNote: true,
                        ));
                  },
                  child: Container(
                    width: AppDimensions.screenWidth(context) / 2,
                      child: VideoItem(resource: resource[index])
                  )
              )
              ;
            });
    }
  }
}
