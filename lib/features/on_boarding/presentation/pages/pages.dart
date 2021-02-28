import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

///Pages that holds UI for the app intro
///Each Page will take 3 parameter
class AppIntroPages extends StatelessWidget{
  final String introAsset;
  final String introTitle;
  final Animation<double> heroAnimation;

  AppIntroPages({
    @required this.introAsset,
    @required this.introTitle,
    this.heroAnimation
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(AppDimensions.dimenEight),
      color: Color(0xFFf3f4f6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /*Page Asset*/
          SizedBox(height: 40.0,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.dimenThirtyTwo),
              child: new SvgPicture.asset(
                introAsset,
                width: AppDimensions.screenWidth(context) * 0.55,
                height: AppDimensions.screenHeight(context) * 0.55,
                semanticsLabel: 'Assset Name',
              ),
            ),
          ),
          /*Page Title*/
          SizedBox(height: 20.0,),
          Expanded(
            child: new Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.dimenTwelve),
              child: new Text(
                  introTitle,
                  style: headerStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.screenWidth(context) * 0.07
                  ).copyWith(
                    letterSpacing: 1.5,
                    height: 1.3,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
