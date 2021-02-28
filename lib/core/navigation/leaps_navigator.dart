import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';

import '../helpers/leaps_route_transition_helper.dart';
///[LeapsAppNavigator] can have:
///Also Full screen dialog can be implemented here
///Navigation without context can be enabled for navigating right
///from the view model classes
///
class LeapsAppNavigator{
  final BuildContext context;
  final Widget page;
  final TransitionType transitionType;
  final NavigationType navigationPushType;

  LeapsAppNavigator({
    @required this.context,
    this.page,
    this.transitionType = TransitionType.Slide,
    this.navigationPushType = NavigationType.Push
  }){
    _materialPageRoute() => LeapsPageRoute(
      page: page,
      transitionType: transitionType,
    );
    switch(navigationPushType){
      case NavigationType.Push:
        Navigator.push(
            context,
            _materialPageRoute()
        );
        break;
      case NavigationType.PushReplacement:
        Navigator.pushReplacement(
            context,
            _materialPageRoute()
        );
        break;
      case NavigationType.PopUntilFirst:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case NavigationType.Pop:
        Navigator.of(context).pop();
        break;
      default:
        Navigator.push(
            context,
            _materialPageRoute()
        );
        break;
    }
  }
}
