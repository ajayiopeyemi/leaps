import 'package:flutter/material.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class NewLeapsSnackbar{
  final BuildContext context;
  final String snackBarText;
  final MessageType messageType;
  NewLeapsSnackbar({
    @required this.context,
    @required this.snackBarText,
    this.messageType
  }){
    IconData _iconData;
    Color _backgroundColor;

    switch(messageType){
      case MessageType.Success:
        _iconData = Icons.check;
        _backgroundColor = AppColors.Green;
        break;
      case MessageType.Error:
        _iconData = Icons.error;
        _backgroundColor = AppColors.Red;
        break;
      case MessageType.Warning:
        _iconData = Icons.warning;
        _backgroundColor = AppColors.Yellow;
        break;
      default:
        _iconData = Icons.check;
        _backgroundColor = AppColors.Green;
        break;
    }

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(snackBarText),
            AppDimensions.horizontalSpacer(),
            Icon(
                _iconData
            )
          ],
        ),
        backgroundColor: _backgroundColor,
      ));
  }
}

class LeapsSnackbar{
  final BuildContext context;
  final String snackBarText;
  final MessageType messageType;
  final GlobalKey<ScaffoldState> globalKey;
  LeapsSnackbar({
    @required this.context,
    @required this.snackBarText,
    this.globalKey,
    this.messageType
  }){
    IconData _iconData;
    Color _backgroundColor;

    switch(messageType){
      case MessageType.Success:
        _iconData = Icons.check;
        _backgroundColor = AppColors.Green;
        break;
      case MessageType.Error:
        _iconData = Icons.error;
        _backgroundColor = AppColors.Red;
        break;
      case MessageType.Warning:
        _iconData = Icons.warning;
        _backgroundColor = AppColors.Yellow;
        break;
      default:
        _iconData = Icons.check;
        _backgroundColor = AppColors.Green;
        break;
    }

    globalKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(snackBarText),
            AppDimensions.horizontalSpacer(),
            Icon(
                _iconData
            )
          ],
        ),
        backgroundColor: _backgroundColor,
      ));
  }
}
