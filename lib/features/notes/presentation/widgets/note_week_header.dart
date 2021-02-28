import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class WeekHeader extends StatelessWidget{
  final String headerText;
  final double marginTop;
  const WeekHeader(this.headerText, this.marginTop);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        children: <Widget>[
          new Text(
            headerText,
            style: headerStyle(),
          ),
          /*Spacer(),
        FlatButton(
          onPressed: () {},
          child: new Text(
            'See All',
            style: bodyStyle(fontWeight: FontWeight.w500),
          ),
        ),*/
        ],
      ),
    );
  }
}