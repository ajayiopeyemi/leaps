import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LeapsStatusBar extends StatelessWidget {
  const LeapsStatusBar({
    Key key,
    this.brightness = Brightness.dark,
    @required this.child,
  }) : super(key: key);

  const LeapsStatusBar.dark({
    @required this.child,
  }) : brightness = Brightness.dark;

  const LeapsStatusBar.light({
    @required this.child,
  }) : brightness = Brightness.light;

  final Widget child;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.Background,
        statusBarIconBrightness: Brightness.dark,
    ));*/
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness == Brightness.dark
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: child,
    );
  }
}
