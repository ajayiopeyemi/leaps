import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/helpers/drop_down_helper.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/authentication/presentation/helpers/auth_notifier.dart';
import 'package:provider/provider.dart';

///
// ignore: must_be_immutable
class LeapsCustomDropDownField extends StatelessWidget {
  final dynamic items;
  bool isCountryNull;
  final RegistrationUseCase useCase;
  ///
  LeapsCustomDropDownField({Key key,
    @required this.items,
    @required this.isCountryNull,
    @required this.useCase
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppDimensions.dimenFour,
            horizontal: AppDimensions.dimenEight
        ),
        child: ChangeNotifierProvider<ValueNotifier<int>>(
          builder: (_) => ValueNotifier<int>(0),
          child: Consumer<ValueNotifier<int>>(
            builder: (_, ValueNotifier<int> selectedIndex, __) => PopupMenuButton(
                onSelected: (index){
                  selectedIndex.value = index;
                  Provider.of<AuthNotifier>(context)
                      .setCountry(items[selectedIndex.value]);
                  Provider.of<AuthNotifier>(context)
                      .setShouldCountryNameShow(value: true);
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(isCountryNull == false || isCountryNull == null ? 'Select a country' : items[selectedIndex.value]),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.Purple,
                        )
                      ],
                    ),
                    Divider(color: AppColors.Black, thickness: 0.5,)
                  ],
                ),
                itemBuilder: (_) => DropDownHelper.buildPopMenuItem(items)
            )
      ),
      ),
    ));
  }
}