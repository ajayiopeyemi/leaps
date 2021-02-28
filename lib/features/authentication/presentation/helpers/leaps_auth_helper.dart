import 'package:flutter/material.dart';
import 'package:leaps/core/components/app_platform_alert_dialog.dart';
import 'package:leaps/core/components/leaps_dialogs.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/features/authentication/data/models/user.dart';
import 'package:leaps/features/authentication/data/services/auth_service.dart';
import 'package:leaps/features/authentication/domain/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LeapsAuthHelper {
  static Future<void> confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: AppString.logout,
      content: AppString.logoutAreYouSure,
      cancelActionText: AppString.cancel,
      defaultActionText: AppString.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      try {
        await Provider.of<AuthService>(context).signOut();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static Future<void> showResetPasswordDialog(BuildContext context) async {
    final bool didRequestPasswordChange = await PlatformAlertDialog(
      title: AppString.PasswordResetTitle,
      content: AppString.PasswordResetDescription,
      cancelActionText: AppString.cancel,
      defaultActionText: AppString.reset,
    ).show(context);
    if (didRequestPasswordChange == true) {
      try {
        Provider.of<AuthService>(context).resetPassword();
      } catch (error) {
        print(error.toString());
        LeapsDialogs.showError(context, AppString.Oops, error);
      }
    }
  }

  static Future<void> showAlert(BuildContext context) async {
    final bool didRequestPasswordChange = await PlatformAlertDialog(
      title: AppString.Oops,
      content: 'You have not selected a country',
      defaultActionText: 'Ok',
    ).show(context);
    if (didRequestPasswordChange == true) {
      Navigator.canPop(context);
    }
  }

  signUpAUser(BuildContext context, AuthViewModel model, User user, String _password) async{
    var signUpSuccess = await model.signUp(
      context: context,
      data: user.dataToMap(),
      password: _password,
    );
    if (signUpSuccess != null) {
      Navigator.pop(context);
    }
  }
}
