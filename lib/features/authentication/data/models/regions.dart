import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaps/core/constants/leaps_strings.dart';

class Regions {
  String country;
  List<dynamic> schools;
  List<dynamic> classes;

  Regions({this.country, this.schools, this.classes});

  Regions.fromMap(Map<String, dynamic> map)
      : assert(map[ResourceConstants.COUNTRY] != null),
        country = map[ResourceConstants.COUNTRY],
        schools = List.of(map[ResourceConstants.SCHOOLS]),
        classes = List.of(map[ResourceConstants.CLASSES]);

  Regions.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}
