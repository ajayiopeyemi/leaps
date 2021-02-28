import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaps/core/constants/leaps_strings.dart';

//Declare final key from the db
class User {
  String uId;
  String avatar;
  String firstName;
  String surname;
  String email;
  String password;

  String country;
  String schoolName;
  String className;

  bool isUserVerified;
  bool isStudent;

  User({
    this.uId,
    this.avatar,
    this.firstName,
    this.surname,
    this.email,
    this.password,
    this.country,
    this.schoolName,
    this.className,
    this.isUserVerified,
    this.isStudent,
  });

  User.map(dynamic obj) {
    this.uId = obj[UserConstants.UID];
    this.avatar = obj[UserConstants.AVATAR];
    this.firstName = obj[UserConstants.FIRST_NAME];
    this.surname = obj[UserConstants.SURNAME];
    this.email = obj[UserConstants.EMAIL];
    this.password = obj[UserConstants.PASSWORD];

    this.country = obj[UserConstants.COUNTRY];
    this.schoolName = obj[UserConstants.SCHOOL_NAME];
    this.className = obj[UserConstants.CLASS];

    this.isUserVerified = obj[UserConstants.IS_USER_VERIFIED];
    this.isStudent = obj[UserConstants.IS_STUDENT];
  }

  Map<String, dynamic> dataToMap() {
    var map = new Map<String, dynamic>();
    map[UserConstants.UID] = uId;
    map[UserConstants.AVATAR] = avatar;
    map[UserConstants.FIRST_NAME] = firstName;
    map[UserConstants.SURNAME] = surname;
    map[UserConstants.EMAIL] = email;
    map[UserConstants.COUNTRY] = country;
    map[UserConstants.SCHOOL_NAME] = schoolName;
    map[UserConstants.CLASS] = className;

    map[UserConstants.IS_USER_VERIFIED] = isUserVerified;
    map[UserConstants.IS_STUDENT] = isStudent;
    /*if(uId.isNotEmpty && uId != null){

    }*/
    return map;
  }

  User.fromSnapshot(DocumentSnapshot snapshot) : this.map(snapshot.data);
}
