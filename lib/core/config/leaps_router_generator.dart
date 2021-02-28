import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/features/authentication/presentation/screens/join_us_screen.dart';
import 'package:leaps/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:leaps/features/notes/presentation/screens/lesson_plan_screen.dart';
import 'package:leaps/features/profile/presentation/screens/profile_screen.dart';
import 'package:leaps/features/search/data/models/search_result.dart';
import 'package:leaps/features/search/presentation/screens/search_result_screen.dart';
import 'package:leaps/src/teacher_entry_point.dart';

import '../../src/app_host.dart';

class LeapsRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.MyApp:
        return MaterialPageRoute(builder: (_) => MyApp());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => TeacherEntryPoint());
      case RoutePaths.JoinUsNow:
        return MaterialPageRoute(builder: (_) => JoinUsScreen());
      case RoutePaths.SignIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case RoutePaths.LessonNote:
        return MaterialPageRoute(builder: (_) => LessonPlanScreen());
      case RoutePaths.Account:
        return MaterialPageRoute(builder: (_) => UserScreen());
      case RoutePaths.SearchResult:
        var searchMetrics = settings.arguments as SearchInput;
        return MaterialPageRoute(builder: (_) => SearchResultScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
