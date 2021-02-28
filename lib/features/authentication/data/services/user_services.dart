import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/utils/firebase_util.dart';
import 'package:leaps/features/authentication/data/models/user.dart';

class UserService implements FirebaseUtil {
  String getAuthUserId() {
    return FirebaseUtil.authUserId;
  }

  Future<dynamic> createUser(Map data) {
    var userDetails =
        FirebaseUtil.userReference.document(data['${UserConstants.UID}']);
    return userDetails.setData(data);
  }

  Future<void> setAvatarReference(String avatar) async {
    var reference = FirebaseUtil.userDocReference;
    Map<String, dynamic> data() {
      var map = new Map<String, dynamic>();
      map[UserConstants.AVATAR] = avatar;
      return map;
    }

    await reference.updateData(data());
  }

  Stream<User> getUserDetails() async* {
    yield* FirebaseUtil.userDocReference
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));
  }
}
