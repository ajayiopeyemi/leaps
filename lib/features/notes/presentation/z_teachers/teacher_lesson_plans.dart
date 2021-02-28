import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/domain/view_models/notes_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/items/note_plan_item.dart';
import '../widgets/lesson_note_empty_state.dart';

class TeacherLessonPlans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseChangeNotifierProvider<NotesViewModel>(
      model: NotesViewModel(noteService: Provider.of(context)),
      builder: (_, model, child) => LayoutBuilder(
        builder: (context, constraint) {
          return StreamProvider<List<Note>>.value(
            value: model.getNotePlans(),
            child: BuildLessonPlan(),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildLessonPlan extends StatelessWidget {
  var notePlans;
  @override
  Widget build(BuildContext context) {
    notePlans = Provider.of<List<Note>>(context);
    if (notePlans == null) {
      return LeapsLoadIndicator.loadingFadingCircle(40.0);
    }

    switch (notePlans.length) {
      case 0:
        return LessonNoteEmptyState();
      default:
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: notePlans.length,
          itemBuilder: (context, index) {
            return NotePlanItem(index: index);
          });
    }
  }
}
