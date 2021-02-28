import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leaps/features/authentication/auth_access.dart';
import 'package:provider/provider.dart';

import '../features/authentication/data/services/auth_service.dart';
import '../features/authentication/presentation/screens/join_us_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<FirebaseUser>(
      stream: auth.onAuthStateChanged,
      builder: (_, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var user = snapshot.data;
          AuthService.setUser(user);
          /*var joinScreen = Navigator.pushReplacementNamed(context, RoutePaths.JoinUsNow);
          var homeScreen = Navigator.pushReplacementNamed(context, RoutePaths.Home);*/
          return user == null ? JoinUsScreen() : AuthorizationAccess();
        } else {
          return JoinUsScreen();
        }
      },
    );
  }
}
