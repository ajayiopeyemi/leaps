import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';
///Results
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/domain/viewmodels/resources_viewmodel.dart';
import 'package:leaps/features/search/presentation/pages/previews/search_pdf_preview.dart';
import 'package:leaps/features/search/presentation/widgets/app_network_connectivity_state.dart';
import 'package:leaps/features/search/presentation/widgets/items/pdf_item.dart';
import 'package:leaps/features/search/presentation/widgets/resource_state_change.dart';
import 'package:leaps/features/search/presentation/widgets/search_error_view.dart';
import 'package:provider/provider.dart';

class PdfPage extends StatelessWidget {
  final String endpoint;
  final String selectedSubject;
  final String searchQuery;

  PdfPage(
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
            return BuildPdfResult(model.resources);
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

class BuildPdfResult extends StatelessWidget {
  final List<Resource> snapshots;
  const BuildPdfResult(this.snapshots);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshots.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PdfPreview(
                              resource: snapshots[index], isForLessonNote: false
                          ),
                          fullscreenDialog: true));
                },
                child: NewPdfItem(resource: snapshots[index])
            );
          }),
    );
  }
}
