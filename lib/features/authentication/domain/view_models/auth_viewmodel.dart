import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/features/authentication/data/services/auth_service.dart';
import 'package:leaps/src/app_host.dart';

import '../../../../core/base/leaps_base_model.dart';

class AuthViewModel extends LeapsBaseModel {
  AuthService _authService;

  AuthViewModel({@required AuthService authService})
      : _authService = authService;

  Future<FirebaseUser> signIn(
      BuildContext context, String email, String password) async {
    var success;
    try {
      setBusy(true);
      success = await _authService.signInWithEmailAndPassword(email, password);
      if (success != null) {
        setBusy(false);
        Navigator.of(context).popUntil((route) => route.isFirst);
        LeapsAppNavigator(
          context: context,
          page: MyApp(),
          navigationPushType: NavigationType.PushReplacement,
        );
      }
      return success;
    } on PlatformException catch (error) {
      if (error.code != 'ERROR_ABORTED_BY_USER') {
        LeapsDialogs.showError(context, AppString.Oops, error);
        setBusy(false);
      }
      throw Exception(error.message);
    }
  }

  Future<FirebaseUser> signUp(
      {BuildContext context, Map data, String password}) async {
    var success;
    try {
      setBusy(true);
      success = await _authService.signUpWithEmailAndPassword(
          data: data, password: password
      );
      if (success != null) {
        setBusy(false);
        Navigator.of(context).popUntil((route) => route.isFirst);
        LeapsAppNavigator(
          context: context,
          page: MyApp(),
          navigationPushType: NavigationType.PushReplacement,
        );
      }
      return success;
    } on PlatformException catch (error) {
      if (error.code != 'ERROR_ABORTED_BY_USER') {
        print(error.toString());
        LeapsDialogs.showError(context, AppString.Oops, error);
        setBusy(false);
      }
      throw Exception(error.message);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    var success;
    try {
      setBusy(true);
      success = await _authService.resetPassword();
      setBusy(false);
      return success;
    } on PlatformException catch (error) {
      if (error.code != 'ERROR_ABORTED_BY_USER') {
        print(error.toString());
        setBusy(false);
      }
      return success;
    }
  }
}
