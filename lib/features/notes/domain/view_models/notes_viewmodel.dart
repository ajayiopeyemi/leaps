import 'package:flutter/widgets.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/data/services/note_service.dart';

import '../../../../core/base/leaps_base_model.dart';

class NotesViewModel extends LeapsBaseModel {
  NoteService _noteService;

  Stream<List<Note>> noteStream;

  NotesViewModel({@required NoteService noteService})
      : _noteService = noteService;

  Future createLessonPlan(BuildContext context, Map data) {
    try {
      return _noteService.createLessonPlan(data);
    } catch (error) {
      print('Error occured: $error');
      LeapsDialogs.showError(context, AppString.Oops, error);
      throw error;
    }
  }

  ///[addResourceToLessonPlan] to [sub]-[collection] under the [lessonPlanDocId]
  Future addResourceToLessonPlan(
      String collection, Map data, String lessonPlanDocId) {
    Future addResource;
    try {
      addResource = _noteService.addResourceToLessonPlan(
          collection, data, lessonPlanDocId);
      return addResource;
    } catch (e) {
      print(e.toString());
      return addResource;
    }
  }

  ///[getNotePlans] from the [LessonPlanCollection]
  ///[LessonPlan] that [CurrentLoggedInUserCreated]
  ///To be used in the [NoteScreen]
  Stream getNotePlans() {
    try {
      return _noteService.getNotePlan();
    } catch (error) {
      throw error;
    }
  }

  ///[getStudentsLessonPlan] from the [LessonPlanCollection]
  ///[LessonPlan] that teacher in [schoolName] & [country] has [Approved]
  ///And to be used in the[ExploreScreen] for [Students]
  Stream getStudentsLessonPlan(selectedSubject) {
    Stream<List<Note>> noteStream;
    try {
      noteStream = _noteService.getNotePlanForStudents(selectedSubject);
      return noteStream;
    } catch (error) {
      throw error;
    }
  }

  ///[getSuggestedLessonPlan] from the [LessonPlanCollection]
  ///[Topics] here are [LessonPlan] in same [RRegion] that are not created by the [CurrentUser]
  ///And to be used in the[ExploreScreen]
  Stream getSuggestedLessonPlan() {
    try {
      noteStream = _noteService.getSuggestedLessonPlans();
      return noteStream;
    } catch (error) {
      print(error);
      return noteStream;
    }
  }

  ///Method to[getClasses] from the database targeting the[CountryCollection]
  ///And to be used in the[RegistrationPage] & [LessonPlanForm]
}
