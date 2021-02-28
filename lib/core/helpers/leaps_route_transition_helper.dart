import 'package:flutter/widgets.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';

class LeapsPageRoute extends PageRouteBuilder {
  final Widget page;
  final TransitionType transitionType;
  LeapsPageRoute({this.page, this.transitionType})
      : super(
            opaque: true,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              switch (transitionType) {
                case TransitionType.Slide:
                  return SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(-1, 0), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  );

                case TransitionType.Scale:
                  return ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn)),
                    child: child,
                  );

                case TransitionType.Fade:
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                default:
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
              }
            });
}
