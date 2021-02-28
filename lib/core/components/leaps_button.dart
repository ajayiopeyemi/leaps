import 'package:flutter/material.dart';

class LeapsButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color btnBak;
  final double btnWidth;
  final double btnHeight;
  final Color textColor;
  final String btnText;
  final double marginTop;
  LeapsButton({
    Key key,
    VoidCallback onPressed,
    @required this.btnBak,
    this.btnWidth,
    this.btnHeight = 50.0,
    @required this.textColor,
    @required this.btnText,
    @required this.marginTop,
  })  : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, marginTop, 0.0, 0.0),
        width: btnWidth,
        height: btnHeight,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: btnBak.withOpacity(0.6), blurRadius: 9),
          ],
        ),
        child: ButtonTheme(
          child: new FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: btnBak,
              child: new Text(btnText, style: TextStyle(color: textColor)),
              onPressed: _onPressed
          ),
        ));
  }
}
