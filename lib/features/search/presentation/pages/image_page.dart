import 'package:flutter/material.dart';
///Results
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/domain/viewmodels/resources_viewmodel.dart';
import 'package:leaps/features/search/presentation/modals/search_image_preview.dart';
import 'package:leaps/features/search/presentation/widgets/app_network_connectivity_state.dart';
import 'package:leaps/features/search/presentation/widgets/items/image_item.dart';
import 'package:leaps/features/search/presentation/widgets/resource_state_change.dart';
import 'package:leaps/features/search/presentation/widgets/search_error_view.dart';
import 'package:provider/provider.dart';

class ImagesPage extends StatelessWidget {
  final String endpoint;
  final String selectedSubject;
  final String searchQuery;

  ImagesPage(
      {Key key,
      @required this.endpoint,
      @required this.selectedSubject,
      @required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseChangeNotifierProvider<ResourcesViewModel>(
      model: ResourcesViewModel(resourceServices: Provider.of(context)),
      onModelReady: (model) =>
          model.getResources(endpoint, selectedSubject, searchQuery),
      builder: (context, model, child) =>
          LayoutBuilder(builder: (context, constraint) {
        var viewHeight = constraint.maxHeight;
        var viewWidth = constraint.maxWidth;

        switch (model.viewStateGet) {
          case ViewStateGet.Loading:
            return LeapsLoadIndicator.loadingPulse(viewHeight / 5);
          case ViewStateGet.hasData:
            return BuildImageResult(model.resources);
          case ViewStateGet.Empty:
            return Container(child: ResourceStateChangeWidget());
          case ViewStateGet.Error:
            return NetworkWidget(
              child: Center(
                  child: SearchErrorView()
              ),
            );
          default:
            return Container();
        }
      }),
    );
  }
}

class BuildImageResult extends StatelessWidget {
  final List<Resource> snapshot;
  const BuildImageResult(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        staggeredTileBuilder: (_) => StaggeredTile.fit(2),
        itemCount: snapshot.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                LeapsDialogs.simpleDialog(
                    context,
                    ImagePreview(
                      resource: snapshot[index],
                      isForLessonNote: false,
                    ));
              },
              child: ImageItem(resource: snapshot[index]));
        });
  }
}
