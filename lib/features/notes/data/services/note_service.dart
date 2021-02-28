import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/utils/firebase_util.dart';
import 'package:leaps/features/notes/data/model/note.dart';
import 'package:leaps/features/notes/data/model/subject.dart';

import '../../../../core/utils/leaps_user_details_util.dart';

class NoteService implements FirebaseUtil {
  ///For offline support do not use [async] &  [await]
  ///As well do not use [Transactions]
  Future<dynamic> createLessonPlan(Map data) {
    var docRef = FirebaseUtil.lessonPlans.document();
    Map<String, dynamic> docId = {'docId': docRef.documentID};
    data.addAll(docId);
    return docRef.setData(data);
  }

  Future<dynamic> addResourceToLessonPlan(
      String collection, Map referencePath, String lessonPlanDocId) {
    ResourceType type;
    if (collection == '${ApiConstants.textRoute}s') {
      type = ResourceType.Text;
    } else if (collection == 'pdf') {
      type = ResourceType.Pdf;
    } else if (collection == ApiConstants.imagesRoute) {
      type = ResourceType.Image;
    } else if (collection == ApiConstants.videosRoute) {
      type = ResourceType.Video;
    }

    switch (type) {
      case ResourceType.Text:
        return FirebaseUtil.lessonPlans
            .document(lessonPlanDocId)
            .collection('texts')
            .document()
            .setData(referencePath);
        break;
      case ResourceType.Pdf:
        return FirebaseUtil.lessonPlans
            .document(lessonPlanDocId)
            .collection('pdfs')
            .document()
            .setData(referencePath);
        break;
      case ResourceType.Image:
        return FirebaseUtil.lessonPlans
            .document(lessonPlanDocId)
            .collection('images')
            .document()
            .setData(referencePath);
        break;
      case ResourceType.Video:
        return FirebaseUtil.lessonPlans
            .document(lessonPlanDocId)
            .collection('videos')
            .document()
            .setData(referencePath);
        break;
      default:
        return null;
    }
  }

  Stream<List<Note>> getNotePlan() {
    return FirebaseUtil.lessons
        .where('uId', isEqualTo: FirebaseUtil.authUserId)
        .snapshots()
        .map((list) =>
            list.documents.map((doc) => Note.fromSnapshot(doc)).toList());
  }

  Future<dynamic> approveLessonPlan(String docId, Map data) {
    var lessonPlan = FirebaseUtil.lessonPlanDocReference(docId);
    return lessonPlan.updateData(data);
  }

  Future<dynamic> deleteLessonPlan(String docId) {
    var lessonPlan = FirebaseUtil.lessonPlanDocReference(docId);
    return lessonPlan.delete();
  }

  searchByName(String searchField) {
    return FirebaseUtil.lessonPlans
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  Stream<List<Note>> getSuggestedLessonPlans() async* {
    yield* FirebaseUtil.lessons
        .where('country', isEqualTo: AppState.userDetails.country)
        .where(NotePlanConstants.IS_APPROVED, isEqualTo: true)
        .limit(20)
        .snapshots()
        .map((list) => list.documents
            .map((doc) => Note.fromSnapshot(doc))
            .where((filter) => filter.uId != AppState.userDetails.uId)
            .toList());
  }

  Stream<List<Note>> getNotePlanForStudents(String selectedSubject) async* {
    yield* FirebaseUtil.lessons
        .where(UserConstants.COUNTRY, isEqualTo: AppState.userDetails.country)
        .where(UserConstants.SCHOOL_NAME, isEqualTo: AppState.userDetails.schoolName)
        .where(UserConstants.CLASS, isEqualTo: AppState.userDetails.className)
        .where(NotePlanConstants.SUBJECT, isEqualTo: selectedSubject)
        .where(NotePlanConstants.IS_APPROVED, isEqualTo: true)
        .snapshots()
        .map((list) =>
            list.documents.map((doc) => Note.fromSnapshot(doc)).toList());
  }

  Stream<List<Subject>> getAllSubjects() async* {
    yield* FirebaseUtil.subjects.snapshots().map((list) =>
        list.documents.map((doc) => Subject.fromSnapshot(doc)).toList());
  }
}
