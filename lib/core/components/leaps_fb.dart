import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class LeapsFloatingActionButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback _callback;
  LeapsFloatingActionButton({
    VoidCallback onPressed,
    this.iconData,
  }) : _callback = onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _callback(),
      backgroundColor: AppColors.Purple,
      mini: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Icon(
        iconData,
        color: AppColors.White,
        size: 18,
      ),
    );
  }
}
