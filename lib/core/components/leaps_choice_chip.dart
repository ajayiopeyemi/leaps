import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class LeapsChoiceChips extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color textColor;

  LeapsChoiceChips(
      {this.icon,
      this.text,
      this.iconColor = AppColors.White,
      this.textColor = AppColors.PrimaryColor});

  @override
  _LeapsChoiceChipsState createState() => _LeapsChoiceChipsState();
}

class _LeapsChoiceChipsState extends State<LeapsChoiceChips> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.White.withOpacity(0.05),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: widget.iconColor,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(widget.text, style: bodyStyle(fontColor: widget.textColor))
        ],
      ),
    );
  }
}
