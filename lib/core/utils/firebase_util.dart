import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaps/features/authentication/data/services/auth_service.dart';

class FirebaseUtil {
  static Firestore instance = Firestore.instance;

  static String get authUserId => AuthService.getUser?.uid ?? "0";

  /*-----------------------*/
  /*---Suggested Topics---*/
  /*---------------------*/
  static Query get suggestedTopics => instance.collection('suggested_topics');

  /*---------------*/
  /*---Subjects & classes---*/
  /*-------------*/
  static Query get subjects => instance.collection('subjects');

  static Query get regions => instance.collection('regions');

  /*-------------------*/
  /*---Lessons Notes---*/
  /*------------------*/
  static Query get lessons => instance.collection('lesson_plans');
  static CollectionReference get lessonPlans => lessons.reference();
  static DocumentReference lessonPlanDocReference(String path) =>
      lessonPlans.document(path);

  /*---------------*/
  /*---Accounts---*/
  /*-------------*/
  //Useful to get all users
  static Query get users => instance.collection('app_users');
  static CollectionReference get userReference => users.reference();
  static DocumentReference get userDocReference =>
      users.reference().document('$authUserId');
  /*static DocumentReference userDocReference(String docId) =>
      users.reference().document(docId);*/
}
