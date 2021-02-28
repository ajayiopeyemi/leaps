import 'package:flutter/material.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/authentication/data/models/user.dart';
import 'package:leaps/features/authentication/data/services/user_services.dart';
import 'package:leaps/features/authentication/presentation/screens/awaiting_verification_screen.dart';
import 'package:leaps/features/authentication/presentation/screens/join_us_screen.dart';
import 'package:leaps/features/authentication/presentation/screens/researcher_on_app_screen.dart';
import 'package:leaps/src/student_entry_point.dart';
import 'package:leaps/src/teacher_entry_point.dart';
import 'package:provider/provider.dart';

import '../splash/presentation/screens/splash_screen.dart';

class AuthorizationAccess extends StatelessWidget {
  /*static User userDetails;*/
  @override
  Widget build(BuildContext context) {
    /*userDetails = Provider.of<User>(context);*/

    return StreamBuilder<User>(
        stream: Provider.of<UserService>(context).getUserDetails(),
        builder: (_, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SplashScreen();

            case ConnectionState.active:
            case ConnectionState.done:
              /*if (!snapshot.hasData && snapshot.data == null) {
                return JoinUsScreen();
              }*/
              var data = snapshot.data;
              var userDetails = data;

              AppState.setUser(data);

              if (!snapshot.hasData && userDetails == null) {
                print('object user details: $userDetails');
                print('object user data: $data');
                return JoinUsScreen();
              }else if (userDetails.isUserVerified == false &&
                  userDetails.isStudent == false) {
                ///[Teacher] - An unverified teacher, students are automatically verified on registration
                return AwaitingVerificationScreen();
              } else if (userDetails.isStudent == null ||
                  userDetails.isUserVerified == null) {
                ///[Researcher] - This is a researcher trying to login to the application
                return ResearcherOnApp();
              }
              return userDetails.isStudent == true
                  ? StudentEntryPoint()
                  : TeacherEntryPoint();
            default:
              return SplashScreen();
          }
        });
  }
}
