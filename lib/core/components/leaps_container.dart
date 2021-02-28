import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LeapsContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius, padding, margin;
  final Color color, shadowColor;
  LeapsContainer(
      {@required this.child,
      @required this.color,
      @required this.shadowColor,
      this.borderRadius = 0.0,
      this.padding = 0.0,
      this.margin = 0.0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      width: width,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
            topLeft: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius)),
        color: color,
        boxShadow: [
          BoxShadow(color: shadowColor.withOpacity(0.2), blurRadius: 9),
        ],
      ),
      child: child,
    );
  }
}
