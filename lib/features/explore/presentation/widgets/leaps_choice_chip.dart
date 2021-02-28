import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class LeapsChoiceChip extends StatefulWidget{
  final int index;
  final String chipAvatar;
  final String chipLabel;
  const LeapsChoiceChip({
    @required this.index,
    @required this.chipAvatar,
    @required this.chipLabel});
  _LeapsChoiceChipState createState() => _LeapsChoiceChipState();
}

class _LeapsChoiceChipState extends State<LeapsChoiceChip>{
  /*bool _isSelected = false;*/
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        widget.chipLabel,
        style: bodyStyle(
          fontSize: AppDimensions.dimenTwelve,
          /*fontColor: _isSelected == true ? AppColors.White : AppColors.PrimaryColor,*/
        ),
      ),
      avatar: SvgPicture.asset(
        widget.chipAvatar,
        /*color: _isSelected == true ? AppColors.White : AppColors.Purple,*/
        width: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),

      backgroundColor: Color(0xFFededed),
      selectedColor: AppColors.Purple,
      selected: _value == widget.index,
      /*selected: _isSelected,*/
      onSelected: (isSelected){
        setState(() {
          _value = isSelected ? widget.index : null;
          /*_isSelected = isSelected;*/
        });
      },
    );
  }
}
