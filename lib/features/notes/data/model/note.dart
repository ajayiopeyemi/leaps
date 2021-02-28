import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaps/core/constants/leaps_strings.dart';

class Note {
  String docId;
  String uId;
  String owner;
  String ownerImg;
  String ownerSchool;
  String country;
  String noteClass;

  String subject;
  int subjectIndex;
  String topic;
  int duration;

  int noOfTextDocs;
  int noOfPdfDocs;
  int noOfImages;
  int noOfVideos;

  bool isApproved;

  /*factory Note.initialData() {
    return Note(loading: LeapsLoadIndicator.loadingThreeBounce(20.0));
  }*/

  Note({
      this.docId,
      this.uId,
      this.owner,
      this.ownerImg,
      this.ownerSchool,
      this.country,
      this.noteClass,
      this.subject,
      this.subjectIndex,
      this.topic,
      this.duration = 2,
      this.noOfTextDocs = 0,
      this.noOfPdfDocs = 0,
      this.noOfImages = 0,
      this.noOfVideos = 0,
      this.isApproved = false});

  Note.map(dynamic obj) {
    this.docId = obj[NotePlanConstants.DOC_ID];
    this.uId = obj[NotePlanConstants.USER_ID];

    this.owner = obj[NotePlanConstants.OWNER];
    this.ownerImg = obj[UserConstants.AVATAR];
    this.ownerSchool = obj[UserConstants.SCHOOL_NAME];
    this.country = obj[UserConstants.COUNTRY];
    this.noteClass = obj[UserConstants.CLASS];

    this.subject = obj[NotePlanConstants.SUBJECT];
    this.subjectIndex = obj[NotePlanConstants.SUBJECT_INDEX];
    this.topic = obj[NotePlanConstants.TOPIC];
    this.duration = obj[NotePlanConstants.DURATION];
    this.noOfTextDocs = obj[NotePlanConstants.NO_OF_TEXT_DOCS];
    this.noOfPdfDocs = obj[NotePlanConstants.NO_OF_PDF_DOCS];
    this.noOfImages = obj[NotePlanConstants.NO_OF_Images];
    this.noOfVideos = obj[NotePlanConstants.NO_OF_VIDEOS];

    this.isApproved = obj[NotePlanConstants.IS_APPROVED];
  }

  //For creating
  Map<String, dynamic> dataToMap() {
    var map = new Map<String, dynamic>();
    map[NotePlanConstants.DOC_ID] = docId;
    map[NotePlanConstants.USER_ID] = uId;

    map[NotePlanConstants.OWNER] = owner;
    map[UserConstants.SCHOOL_NAME] = ownerSchool;
    map[UserConstants.AVATAR] = ownerImg;
    map[UserConstants.COUNTRY] = country;
    map[UserConstants.CLASS] = noteClass;

    map[NotePlanConstants.SUBJECT] = subject;
    map[NotePlanConstants.SUBJECT_INDEX] = subjectIndex;
    map[NotePlanConstants.TOPIC] = topic;
    map[NotePlanConstants.DURATION] = duration;
    map[NotePlanConstants.NO_OF_TEXT_DOCS] = noOfTextDocs;
    map[NotePlanConstants.NO_OF_PDF_DOCS] = noOfPdfDocs;
    map[NotePlanConstants.NO_OF_Images] = noOfImages;
    map[NotePlanConstants.NO_OF_VIDEOS] = noOfVideos;

    map[NotePlanConstants.IS_APPROVED] = isApproved;

    return map;
  }

  Note.fromSnapshot(DocumentSnapshot snapshot) : this.map(snapshot.data);

  Note.fromFutureSnapshot(Future<DocumentSnapshot> snapshot)
      : this.map(snapshot);
}
