import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/notes/domain/view_models/notes_viewmodel.dart';
import 'package:provider/provider.dart';

import '../modals/lesson_plan_form.dart';
import '../z_teachers/teacher_lesson_plans.dart';

class LessonPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDetails = AppState.userDetails;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Lesson Plans'),
          ),
          body: BaseChangeNotifierProvider<NotesViewModel>(
            model: NotesViewModel(noteService: Provider.of(context)),
            onModelReady: (model) => model.getNotePlans(),
            builder: (context, model, child) => LayoutBuilder(
              builder: (context, constraint) {
                return TeacherLessonPlans();
              },
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              LeapsDialogs.simpleDialog(context, NewLessonPlanForm()),
          backgroundColor: AppColors.Purple,
          mini: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Icon(
            Icons.add,
            color: AppColors.White,
            size: 18,
          ),
        ),
      ),
    );
  }
}
