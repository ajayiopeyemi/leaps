import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaps/core/constants/leaps_strings.dart';

class Resource {
  String filePath;
  String thumbnail;
  String subject;
  String topic;
  String classes;
  String excerpt;
  String definition;
  String heading;
  String title;
  String duration;
  String week;
  String path;
  String country;

  bool isPending;

  Resource({
    this.filePath,
    this.thumbnail,
    this.subject,
    this.topic,
    this.classes,
    this.definition,
    this.excerpt,
    this.heading,
    this.title,
    this.duration,
    this.week,
    this.path,
    this.isPending,
    this.country
  }) : assert(subject != null, topic != null);

  Resource.map(dynamic map) {
    this.heading = map[ResourceConstants.HEADING];
    this.filePath = map[ResourceConstants.FILE_PATH];
    this.thumbnail = map[ResourceConstants.THUMBNAIL];
    this.subject = map[ResourceConstants.SUBJECT];
    this.topic = map[ResourceConstants.TOPIC];
    this.classes = map[ResourceConstants.CLASSES];
    this.definition = map[ResourceConstants.DEFINITION];
    this.excerpt = map[ResourceConstants.EXCERPT];
    this.title = map[ResourceConstants.TITLE];
    this.duration = map[ResourceConstants.DURATION];
    this.week = map[ResourceConstants.WEEK];
    this.path = map[ResourceConstants.PATH];
    this.country = map['user_country'];

    this.isPending = map[ResourceConstants.IS_PENDING];
  }
  Resource.fromSnapshot(DocumentSnapshot snapshot) : this.map(snapshot.data);

  Resource.fromFutureSnapshot(Stream<DocumentSnapshot> snapshot) {
    snapshot.listen((list) {
      print('The heading is: ${Resource.map(list.data).heading}');
      print('Is data ready: ${list.reference.path}');
      return Resource.map(list.data);
    });
  }
}
