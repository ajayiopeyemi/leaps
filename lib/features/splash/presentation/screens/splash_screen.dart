import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Background,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      top: true,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraint) {
            final height = constraint.maxHeight;
            final width = constraint.maxWidth;

            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color: AppColors.Background,
                ),
                Positioned(
                    left: -(width * 0.15),
                    child: new RotationTransition(
                      turns: new AlwaysStoppedAnimation(90 / 360),
                      child: Image.asset(
                        AppImages.PencilAsset,
                        width: width,
                        height: height,
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.Logo,
                    width: width * 0.8,
                    height: width * 0.8,
                  ),
                ),
                Positioned(
                  top: height * 0.85,
                  left: width / 2,
                  child: SpinKitFadingCube(
                    color: AppColors.Purple,
                    size: 40.0,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
