import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class LeapsLoadIndicator {
  static loadingThreeBounce(double size) => SpinKitThreeBounce(
        color: AppColors.Purple,
        size: size,
      );

  static loadingFadingCircle(double size) => SpinKitFadingCircle(
        color: AppColors.Purple,
        size: size,
      );

  static loadingDoubleBounce(double size) => SpinKitDoubleBounce(
        color: AppColors.Purple,
        size: size,
      );

  static loadingPulse(double size) => SpinKitPulse(
        color: AppColors.Purple,
        size: size,
      );
}
