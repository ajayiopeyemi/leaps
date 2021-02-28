import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/domain/view_models/notes_viewmodel.dart';
import 'package:leaps/features/notes/presentation/widgets/empty_suggested_lesson_plan_view.dart';
import 'package:leaps/features/notes/presentation/widgets/items/suggested_note_plan_item_card.dart';
import 'package:provider/provider.dart';

class SuggestedLessonPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseChangeNotifierProvider<NotesViewModel>(
      model: NotesViewModel(noteService: Provider.of(context)),
      onModelReady: (model) => model.getSuggestedLessonPlan(),
      builder: (context, model, child) => LayoutBuilder(
        builder: (context, constraint) {
          return StreamProvider<List<Note>>.value(
              value: model.getSuggestedLessonPlan(),
              child: BuildSuggestedLessonPlan()
          );
        },
      ),
    );
  }
}

class BuildSuggestedLessonPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var suggestedTopics = Provider.of<List<Note>>(context);
    if (suggestedTopics == null) {
      return LeapsLoadIndicator.loadingPulse(40.0);
    }else{
      switch (suggestedTopics.length) {
        case 0:
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmptySuggestedLessonPlanView()
            ),
          );
        default:
        return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            staggeredTileBuilder: (_) => StaggeredTile.fit(2),
            itemCount: suggestedTopics.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return SuggestedLessonPlanItemCard(note: suggestedTopics[index]);
            });
      }
    }
  }
}
