import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/utils/firebase_util.dart';
import 'package:leaps/features/authentication/data/models/user.dart';

import 'user_services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final UserService _userService = UserService();

class AuthService implements FirebaseUtil {
  static FirebaseUser _user;
  static User _userDetails;

  static FirebaseUser setUser(FirebaseUser user) => _user = user;
  static FirebaseUser get getUser => _user;

  static User setUserDetails(User userDetails) => _userDetails = userDetails;
  static User get getUserDetails => _userDetails;

  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    setUser(user);
    return user;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResult user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    setUser(user.user);
    return user.user;
  }

  Future<FirebaseUser> signUpWithEmailAndPassword(
      {Map data, String password}) async {
    _user = await _auth
        .createUserWithEmailAndPassword(
            email: data['${UserConstants.EMAIL}'], password: password)
        .then((result) {
      assert(result != null);
      print('UserId is: ${result.user.uid}');
      Map<String, dynamic> otherDetails = {
        UserConstants.UID: result.user.uid,
      };
      data.addAll(otherDetails);
      _userService.createUser(data);
      return result.user;
    });
    setUser(_user);
    return _user;
  }

  ///[signUpWithEmailAndPassword] is to be used by both [Normal_Users], & [Normal_admin]
  Future<FirebaseUser> signUp(Map data, String password) async {
    _user = await _auth
        .createUserWithEmailAndPassword(
            email: data['${UserConstants.EMAIL}'], password: password)
        .then((result) {
      assert(result != null);
      print('UserId is: ${result.user.uid}');
      Map<String, dynamic> authUserId = {UserConstants.UID: result.user.uid};
      data.addAll(authUserId);
      _userService.createUser(data);
      return result.user;
    });
    setUser(_user);
    return _user;
  }

  Future<User> getUserDetailsDoc() async {
    var thisUser = await FirebaseUtil.userDocReference
        .get()
        .then((snapshot) => User.fromSnapshot(snapshot));
    setUserDetails(thisUser);

    print('Is user student: ${_userDetails.isStudent}');
    return thisUser;
  }

  Future<Null> resetPassword() async {
    await _auth.sendPasswordResetEmail(email: _user.email);
    signOut();
  }

  Future<Null> signOut() async {
    // Sign out with firebase
    await _auth.signOut();
    // Clear state
    _user = null;
  }
}
