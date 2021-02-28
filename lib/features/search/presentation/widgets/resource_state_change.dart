import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';

class ResourceStateChangeWidget extends StatelessWidget {
  final bool isEmptyState;

  ResourceStateChangeWidget({this.isEmptyState = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constraint) {
        var viewHeight = constraint.maxHeight;
        var viewWidth = constraint.maxHeight;

        return SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: isEmptyState
                        ? Container(
                            height: viewHeight * 0.5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      AppImages.NoSearchResult,
                                    ),
                                    fit: BoxFit.cover)),
                          )
                        : SvgPicture.asset(
                            AppSVGs.Internet,
                            height: viewHeight * 0.5,
                            width: viewWidth * 0.5,
                          )),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isEmptyState ? AppString.Uhm : AppString.Oops,
                    style:
                        headerStyle(fontSize: 28, fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    isEmptyState
                        ? AppString.NoResultDescription
                        : AppString.DeviceOfflineDescription,
                    style: bodyStyle(fontSize: 14, fontWeight: FontWeight.w100, fontColor: AppColors.Black),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.topLeft,
                  child: LeapsButton(
                    btnBak: AppColors.Purple,
                    marginTop: 18.0,
                    btnText: 'Home',
                    textColor: AppColors.White,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
