import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/authentication/presentation/screens/join_us_screen.dart';
import 'package:leaps/features/on_boarding/presentation/pages/pages.dart';

import '../helpers/on_boarding_helper.dart';
import '../widgets/page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  _OnBoardingScreenState createState() => new _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with SingleTickerProviderStateMixin{
  final _controller = new PageController();
  int page = 0;

  AnimationController _animationController;
  Animation<double> _heroAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(microseconds: 750));
    _heroAnimation = Tween<double>(begin: -40, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut)
    );
    _animationController.forward(from: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFf3f4f6),
        statusBarIconBrightness: Brightness.dark
    ));
    final List<Widget> _pages = [
      /*Page 1*/
      AppIntroPages(
        introAsset: AppSVGs.digital,
        introTitle: 'LeaPS\nyour digital\nresource library',
      ),
      /*Page 2*/
      AppIntroPages(
        introAsset: AppSVGs.handpicked_resources,
        introTitle: 'Discover\ncarefully-selected digital\neducational resources',
      ),
      /*Page */
      AppIntroPages(
        introAsset: AppSVGs.collaboration,
        introTitle: "See what\nteachers\nhave curated",
      ),
      /*Page 4*/
      AppIntroPages(
        introAsset: AppSVGs.studying,
        introTitle: 'Study anywhere\nat your\ncomfort',
      ),
    ];
    bool isDone = page == _pages.length - 1;

    var width = AppDimensions.screenWidth(context);
    var height = AppDimensions.screenHeight(context);

    return SafeArea(
      top: true,
      child: new Scaffold(
        backgroundColor: Color(0xFFf3f4f6),
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
                child: new PageView.builder(
                  physics: new AlwaysScrollableScrollPhysics(),
                  itemCount: _pages.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimatedBuilder(
                      animation: _heroAnimation,
                      builder: (context, child) =>
                          Transform.translate(
                            offset: Offset(_heroAnimation.value, 0),
                            child: _pages[index % _pages.length]
                          ),
                    );
                    /*return _pages[index % _pages.length];*/
                  },
                  onPageChanged: (int newPage) {
                    setState(() {
                      page = newPage;
                    });
                  },
                )
            ),
            Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Text(
                  'Skip',
                  style: TextStyle(color: AppColors.Purple),
                ),
                onPressed: () {
                  debugPrint('Skip is clicked');
                  _endOnBoarding();
                },
                splashColor: Colors.transparent,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 42.0, horizontal: 20.0),
                child: new PageIndicator(
                  pageController: _controller,
                  itemCount: _pages.length,
                  onPageSelected: (int page) {
                    _controller.animateToPage(
                        page,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: isDone ? Alignment.bottomRight : Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                child: InkWell(
                    onTap: isDone ? () {
                      _endOnBoarding();
                      debugPrint('End of page');
                    } : () {
                      _controller.animateToPage(page + 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: isDone ?
                    Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            color: AppColors.Purple,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Get Started",
                              style: TextStyle(color: AppColors.White),
                            ),
                          ),
                        )
                    ) :
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.Purple,
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.White,
                        ),
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _endOnBoarding() async{
    await OnBoardingHelper.setOnBoardingStatus();
    LeapsAppNavigator(
        context: context,
        page: JoinUsScreen(),
        navigationPushType: NavigationType.PushReplacement
    );
  }
}
