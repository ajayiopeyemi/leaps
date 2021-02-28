import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaps/core/constants/leaps_strings.dart';

class Subject {
  final String name;

  Subject.fromMap(Map<String, dynamic> map)
      : assert(map[ResourceConstants.NAME] != null),
        name = map[ResourceConstants.NAME];

  Subject.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}
