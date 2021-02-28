import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leaps/core/navigation/leaps_bottom_nav_bar.dart';
import 'package:leaps/core/navigation/notifiers/leaps_navigation_state_notifier.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/notes/presentation/screens/lesson_plan_screen.dart';
import 'package:leaps/features/profile/presentation/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../features/explore/presentation/screens/explore_screen.dart';

class TeacherEntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var navBarProvider = Provider.of<LeapsNavigationStateNotifier>(context);
    final List<Widget> _pages = [ExploreScreen(), LessonPlanScreen(), UserScreen()];
    final List<BarItem> batItem = [
      BarItem(
          text: 'Explore',
          icon: FontAwesomeIcons.search,
          color: AppColors.Purple),
      BarItem(
          text: 'Notes',
          icon: FontAwesomeIcons.bookReader,
          color: AppColors.Purple),
      BarItem(
          text: 'Account',
          icon: FontAwesomeIcons.userCircle,
          color: AppColors.Purple),
    ];

    return Scaffold(
      backgroundColor: AppColors.White,
      body: AnimatedContainer(
        duration: const Duration(microseconds: 400),
        color: batItem[navBarProvider.currentTeacherIndex].color,
        child: _pages[navBarProvider.currentTeacherIndex],
      ),
      bottomNavigationBar: LeapsBottomNavBar(
        barItems: batItem,
        animationDuration: const Duration(milliseconds: 200),
        barStyle: BarStyle(
          fontSize: 14.0,
          iconSize: 20.0,
        ),
        onBarTap: (index) {
          navBarProvider.currentTeacherIndex = index;
        },
      ),
    );
  }
}
