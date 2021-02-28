import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class LeapsOnlyIconButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color btnBak;
  final double verticalMargin;
  LeapsOnlyIconButton({
    Key key,
    @required VoidCallback onPressed,
    @required this.btnBak,
    this.verticalMargin,
  })  : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPressed,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: verticalMargin),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.circular(16.0)),
            color: btnBak,
            boxShadow: [
              BoxShadow(color: btnBak.withOpacity(0.6), blurRadius: 9),
            ],
          ),
        child: Center(
          child: new Icon(
            Icons.add,
            color: AppColors.White,
          ),
        ),
          /*child: new FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: btnBak,
              onPressed: _onPressed
          )*/
      ),
    );
  }
}
