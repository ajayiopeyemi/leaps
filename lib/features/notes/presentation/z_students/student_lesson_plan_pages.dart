import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/domain/view_models/notes_viewmodel.dart';
import 'package:leaps/features/notes/presentation/z_teachers/teacher_lesson_plans.dart';
import 'package:provider/provider.dart';

class StudentLessonPlan extends StatelessWidget {
  final String selectedSubject;
  StudentLessonPlan(this.selectedSubject);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedSubject,
          style: bodyStyle(
            fontColor: AppColors.White,
            fontSize: 18.0
          ),
        ),
      ),
      body: BaseChangeNotifierProvider<NotesViewModel>(
        model: NotesViewModel(noteService: Provider.of(context)),
        builder: (_, model, child) => LayoutBuilder(
          builder: (context, constraint) {
            return StreamProvider<List<Note>>.value(
              value: model.getStudentsLessonPlan(selectedSubject),
              child: BuildLessonPlan(),
            );
          },
        ),
      ),
    );
  }
}