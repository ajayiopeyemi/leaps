import 'package:leaps/core/utils/firebase_util.dart';
import 'package:leaps/features/authentication/data/models/regions.dart';

class RegionService implements FirebaseUtil {
  Stream<List<Regions>> getCountries() async* {
    yield* FirebaseUtil.regions.snapshots().map((list) =>
        list.documents.map((doc) => Regions.fromSnapshot(doc)).toList());
  }

  Future<List<String>> fetchSchool(String country) async{
    List<String> schoolInApp = [];
    await FirebaseUtil.regions
        .where('country', isEqualTo: country)
        .getDocuments().then((result){

      return result.documents.map((snapshot){
        var schoolList = Regions.fromSnapshot(snapshot).schools;
        schoolInApp.clear();
        schoolList.forEach((schools) => schoolInApp.add(schools));
      }).toList();
    });
    return schoolInApp;
  }

  Future<List<String>> fetchClasses(String country) async{
    List<String> userCLasses = [];
    await FirebaseUtil.regions
        .where('country', isEqualTo: country)
        .getDocuments().then((result){

      return result.documents.map((snapshot){
        var schoolList = Regions.fromSnapshot(snapshot).classes;
        userCLasses.clear();
        schoolList.forEach((schools) => userCLasses.add(schools));
      }).toList();
    });
    return userCLasses;
  }

  ///*************************************************************************
  /*Stream<List<Regions>> getClassesInRegion(String teacherCountry) async* {
    List<String> classesFromServer = [];
    yield* FirebaseUtil.regions
        .where('country', isEqualTo: teacherCountry)
        .snapshots()
        .map((list) {
      return list.documents.map((doc) {
        var result = Regions.fromSnapshot(doc);
        var classList = result.classes;
        classesFromServer.clear();
        classList.forEach((classes) => classesFromServer.add(classes));
        classes = new List.from(['Select class'])..addAll(classesFromServer);
      }).toList();
    });
  }*/
}
