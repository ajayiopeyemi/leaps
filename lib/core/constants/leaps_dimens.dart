import 'package:flutter/material.dart';

class AppDimensions {
  static const double dimenTwo = 2.0;
  static const double dimenFour = 4.0;
  static const double dimenSix = 6.0;
  static const double dimenEight = 8.0;
  static const double dimenTen = 10.0;
  static const double dimenTwelve = 12.0;
  static const double dimenFourteen = 14.0;
  static const double dimenSixteen = 16.0;
  static const double dimenEighteen = 18.0;
  static const double dimenTwenty = 20.0;
  static const double dimenTwentyTwo = 22.0;
  static const double dimenTwentyFour = 24.0;
  static const double dimenThirty = 30.0;
  static const double dimenThirtyTwo = 32.0;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static horizontalSpacer({spaceSize = AppDimensions.dimenEight}) =>
      SizedBox(width: spaceSize);
  static verticalSpacer({spaceSize = AppDimensions.dimenEight}) =>
      SizedBox(height: spaceSize);
}

class AppEdgeInsets {
  static const EdgeInsets allTwo = EdgeInsets.all(2.0);
  static const EdgeInsets allFour = EdgeInsets.all(4.0);
  static const EdgeInsets allSix = EdgeInsets.all(6.0);
  static const EdgeInsets allEight = EdgeInsets.all(8.0);
  static const EdgeInsets allTen = EdgeInsets.all(10.0);
  static const EdgeInsets allTwelve = EdgeInsets.all(12.0);
  static const EdgeInsets allFourteen = EdgeInsets.all(14.0);
  static const EdgeInsets allSixteen = EdgeInsets.all(16.0);
  static const EdgeInsets allTwentyFour = EdgeInsets.all(24.0);
}
