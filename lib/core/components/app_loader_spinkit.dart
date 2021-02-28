import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class BtnSpinKit extends StatelessWidget {
  final Color btnBak = AppColors.Purple;
  final double btnSize = 50.0;
  final double marginTop;
  BtnSpinKit({Key key, @required this.marginTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, marginTop, 0.0, 0.0),
        width: btnSize,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: btnBak.withOpacity(0.6), blurRadius: 9),
          ],
        ),
        child: new Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: btnBak,
          child: new SpinKitThreeBounce(
            color: AppColors.White,
            size: 30,
          ),
        ));
  }
}
