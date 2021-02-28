import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leaps/core/themes/leaps_colors.dart';

class PageIndicator extends AnimatedWidget{
  PageIndicator({
    this.pageController,
    this.itemCount,
    this.onPageSelected,
  }) : super(listenable: pageController);

  final PageController pageController;
  final int itemCount;
  final ValueChanged<int> onPageSelected;

  static const double _indicatorSize = 6.0;
  static const double _indicatorZoom = 1.5;

  Widget _buildIndicator(int index){
    double selected = Curves.easeOutSine.transform(
      max(
        0.0,
        1.0 - ((pageController.page ?? pageController.initialPage) - index).abs()
      )
    );
    double zoom = 1.0 + (_indicatorZoom - 1.0) * selected;
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: AppColors.Purple,
        type: MaterialType.circle,
        child: Container(
          width:  _indicatorSize * zoom,
          height: _indicatorSize * zoom,
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: new List<Widget>.generate(itemCount, _buildIndicator),
    );
  }
}
