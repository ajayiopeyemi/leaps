import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaps/core/helpers/leaps_platform_exception_alert_dialog.dart';

class LeapsDialogs {
  final Widget child;
  LeapsDialogs({@required this.child});

  static simpleDialog(context, child) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return LayoutBuilder(
            builder: (context, constraint) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                  width: constraint.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.transparent,
                  ),
                  child: child,
                ),
              );
            },
          );
        });
  }

  static bottomModalSheet(context, child) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                color: Color(0xFF737373),
                child: Container(
                  width: constraint.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: child,
                ),
              );
            },
          );
        });
  }

  /*static Future<ImageSource> appImageChoiceDialog(context, child){
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return LayoutBuilder(
            builder: (context, constraint){
              return Container(
                color: Color(0xFF737373),
                child: Container(
                  width: constraint.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)
                    ),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: child,
                ),
              );
            },
          );
        }
    );
  }*/

  static snackBar(BuildContext context, String content) {
    final snackBar =
        SnackBar(content: Text(content), duration: new Duration(seconds: 2));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Future<void> showError(
      BuildContext context, String title, PlatformException exception) async {
    await LeapsPlatformExceptionAlertDialog(
      title: title,
      exception: exception,
    ).show(context);
  }
}
