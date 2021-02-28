import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/navigation/notifiers/leaps_navigation_state_notifier.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:provider/provider.dart';

class LeapsBottomNavBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  final BarStyle barStyle;

  LeapsBottomNavBar(
      {this.barItems,
      this.animationDuration = const Duration(milliseconds: 500),
      this.onBarTap,
      this.barStyle});

  @override
  _LeapsBottomNavBarState createState() => new _LeapsBottomNavBarState();
}

class _LeapsBottomNavBarState extends State<LeapsBottomNavBar>
    with TickerProviderStateMixin {
  var selectedBarIndex;
  bool isStudent = AppState.userDetails.isStudent;
  @override
  Widget build(BuildContext context) {
    selectedBarIndex = Provider.of<LeapsNavigationStateNotifier>(context);

    return LayoutBuilder(builder: (context, constraint) {
      var screenHeight = constraint.maxHeight;
      var screenWidth = constraint.maxWidth;

      ///The parent container that holds the items of each navigation
      return Container(
        width: screenWidth,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildBarItem()),
      );
    });
  }

  List<Widget> _buildBarItem() {
    List<Widget> _barItems = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      bool isSelected;
      isStudent == true
          ? isSelected = selectedBarIndex.currentStudentIndex == i
          : isSelected = selectedBarIndex.currentTeacherIndex == i;

      BarItem item = widget.barItems[i];
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          isStudent == true
              ? selectedBarIndex.currentStudentIndex = i
              : selectedBarIndex.currentTeacherIndex = i;
        },
        child: AnimatedContainer(
          duration: widget.animationDuration,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Row(
            children: <Widget>[
              Icon(
                item.icon,
                color: isSelected ? item.color : Colors.black38,
                size: widget.barStyle.iconSize,
              ),
              SizedBox(
                width: AppDimensions.dimenTen,
              ),
              AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.bounceIn,
                vsync: this,
                child: !isStudent
                    ? Text(
                        isSelected ? item.text : "",
                        style: TextStyle(
                            color: item.color,
                            fontSize: widget.barStyle.fontSize),
                      )
                    : Text(
                        item.text,
                        style: TextStyle(
                            color: isSelected
                                ? item.color
                                : AppColors.PrimaryColor,
                            fontSize: widget.barStyle.fontSize),
                      ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}

class BarStyle {
  final double fontSize, iconSize;

  BarStyle({this.fontSize = 24.0, this.iconSize = 32.0});
}

class BarItem {
  String text;
  IconData icon;
  Color color;

  BarItem({this.text, this.icon, this.color});
}
