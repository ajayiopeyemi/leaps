import 'package:flutter/material.dart';

const List<Color> subjectsColors = [
  AppColors.Yellow,
  AppColors.Purple,
  AppColors.Red
];

/*---------------*/
///App background colors
/*---------------*/
class BackgroundColors {
  static const Color backgroundColor = const Color(0xFFE4E6F1);
  static final Color firstCircleColor = Colors.white.withOpacity(0.3);
  static final Color secondCircleColor = Colors.white.withOpacity(0.4);
  static final Color thirdCircleColor = Colors.white.withOpacity(0.6);

  static final Color containerFirstColor = const Color(0xFFEEF4FD);
  static final Color containerSecondColor = const Color(0xFFF4F7FC);
  static final Color containerThirdColor = const Color(0xFFFAFAFA);

  static final Color firstPurpleCircleColor = Colors.white.withOpacity(0.9);
  static final Color secondPurpleCircleColor = Colors.white.withOpacity(0.1);
  static final Color thirdPurpleCircleColor = Colors.white.withOpacity(0.2);
}

/*---------------*/
///App colors
/*---------------*/
class AppColors {
  static const Color Yellow = const Color(0xFFF5B041);
  static const Color Green = const Color(0xFF66BB6A);
  static const Purple = const Color(0xFF7B68EE);
  static const Color Red = const Color(0xFFF1467A);

  static const Color Transparent = Colors.transparent;
  static const Color White = Colors.white;
  static const Color Black = Color(0xFF000000);
  static const Color PrimaryColor = Colors.black26;
  static const Color OffWhite = Colors.white70;
  static const Color OffWhiteThick = Colors.white30;

  static const Color Background = Color(0xFFE8E6E9);

  /*---------------*/
  ///Subject Colors colors
/*---------------*/
  static const List<Color> subjectsColors = [
    AppColors.Yellow,
    AppColors.Purple,
    AppColors.Red
  ];
}

/*---------------------*/
///App Gradients
/*---------------------*/
class AppGradients {
  static const InkGradient = LinearGradient(
    tileMode: TileMode.mirror,
    colors: [
      const Color(0xFFF1467A),
      const Color(0xFFFB949E)
    ], // whitish to gray
  );

  static const LinearGradient blueGradient = LinearGradient(
    tileMode: TileMode.mirror,
    colors: [const Color(0xFF6155D4), const Color(0xFF5B97F2)],
  );

  static const LinearGradient AppPurple = LinearGradient(
    tileMode: TileMode.mirror,
    colors: [
      AppColors.Purple,
      AppColors.Purple,
    ],
  );

  static LinearGradient deepBlueGradient = LinearGradient(
    tileMode: TileMode.mirror,
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      const Color(0xFF484C91).withOpacity(0.7),
      const Color(0xFF929BEF).withOpacity(0.1),
    ],
  );
}
