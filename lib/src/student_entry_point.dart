import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leaps/core/navigation/leaps_bottom_nav_bar.dart';
import 'package:leaps/core/navigation/notifiers/leaps_navigation_state_notifier.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/profile/presentation/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../features/notes/presentation/z_students/student_screen.dart';

class StudentEntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Purple,
        statusBarIconBrightness: Brightness.light));
    var navBarProvider = Provider.of<LeapsNavigationStateNotifier>(context);

    /*final List<Widget> _pages = [StudentNoteScreen(), UserScreen()];*/
    final List<Widget> _pages = [StudentNoteScreen(), UserScreen()];

    final List<BarItem> batItem = [
      BarItem(
          text: 'Explore',
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
        color: batItem[navBarProvider.currentStudentIndex].color,
        child: _pages[navBarProvider.currentStudentIndex],
      ),
      bottomNavigationBar: LeapsBottomNavBar(
        barItems: batItem,
        animationDuration: const Duration(milliseconds: 200),
        barStyle: BarStyle(
          fontSize: 14.0,
          iconSize: 20.0,
        ),
        onBarTap: (index) {
          navBarProvider.currentStudentIndex = index;
        },
      ),
    );
  }
}
