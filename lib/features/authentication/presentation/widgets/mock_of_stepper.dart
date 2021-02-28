import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class MockOfStepper extends StatelessWidget{
  final int pageIndex;
  final bool isStudent;
  MockOfStepper({this.pageIndex, this.isStudent});
  @override
  Widget build(BuildContext context) {
    return isStudent == true ? _buildStudentStepper(context) : _buildTeacherStepper(context);
  }

  Widget _buildTeacherStepper(BuildContext context){
    switch(pageIndex){
      case 1:
        return Row(
          children: <Widget>[
            _activeCircularAvatar(),
            _divider(),
            _inActiveCircularAvatar(),
          ],
        );
        break;
      case 2:
        return Row(
          children: <Widget>[
            _activeCircularAvatar(),
            _divider(),
            _activeCircularAvatar(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  Widget _buildStudentStepper(BuildContext context){
    switch(pageIndex){
      case 1:
        return Row(
          children: <Widget>[
            _activeCircularAvatar(),
            _divider(),
            _inActiveCircularAvatar(),
            _divider(),
            _inActiveCircularAvatar(),
          ],
        );
        break;
      case 2:
        return Row(
          children: <Widget>[
            _activeCircularAvatar(),
            _divider(),
            _activeCircularAvatar(),
            _divider(),
            _inActiveCircularAvatar(),
          ],
        );
        break;
      case 3:
        return Row(
          children: <Widget>[
            _activeCircularAvatar(),
            _divider(),
            _activeCircularAvatar(),
            _divider(),
            _activeCircularAvatar(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  _activeCircularAvatar() => CircleAvatar(
    backgroundColor: AppColors.Purple,
    radius: 15,
    child: Icon(
      Icons.check,
      color: AppColors.White,
      size: 15,
    ),
  );
  _divider() => Expanded(
    child: Divider(
      thickness: 1.0,
    ),
  );
  _inActiveCircularAvatar() => CircleAvatar(
    backgroundColor: AppColors.PrimaryColor,
    radius: 15,
    child: Icon(
      Icons.edit,
      color: AppColors.White,
      size: 15,
    ),
  );
}