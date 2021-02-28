import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaps/core/components/leaps_asset_with_text.dart';
import 'package:leaps/core/components/leaps_snackbar_content.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/core/utils/leaps_user_details_util.dart';
import 'package:leaps/features/search/presentation/screens/search_result_screen.dart';

class NewSearchCardView extends StatefulWidget {
  @override
  _NewSearchCardViewState createState() => _NewSearchCardViewState();
}

class _NewSearchCardViewState extends State<NewSearchCardView> {
  int _value;
  String selectedSubject;

  TextEditingController _searchController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _searchController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _submitSearchField(){
      if(selectedSubject == null || selectedSubject.isEmpty){
        NewLeapsSnackbar(
            context: context,
            snackBarText: "Subject can't be empty",
            messageType: MessageType.Error
        );
      }else if(_formKey.currentState.validate()){
        LeapsAppNavigator(
            context: context,
            page: InheritedSearchResult(
              selectedSubject: selectedSubject,
              searchText: _searchController.text,
              child: SearchResultScreen(),
            )
        );
      }
    }
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      elevation: 3.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: AppDimensions.screenWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select a subject to search from',
            ),
            AppDimensions.verticalSpacer(spaceSize: 16.0),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 3.0,
              runSpacing: 1.0,
              children: List<Widget>.generate(
                  3, (int index){
                return ChoiceChip(
                  label: Text(
                    subjects[index],
                    style: bodyStyle(
                      fontSize: AppDimensions.dimenTwelve,
                      fontColor: _value == index ? AppColors.White : AppColors.PrimaryColor,
                    ),
                  ),
                  avatar: SvgPicture.asset(
                    AppSVGs.subjectsIcons[index],
                    color: _value == index ? AppColors.White : AppColors.Purple,
                    width: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),

                  backgroundColor: Color(0xFFededed),
                  selectedColor: AppColors.Purple,
                  selected: _value == index,
                  onSelected: (selected){
                    setState(() {
                      _value = selected ? index : null;
                      selectedSubject = subjects[index];
                    });
                  },
                );
              }
              ),
            ),
            AppDimensions.verticalSpacer(spaceSize: 60.0),
            Form(
              key: _formKey,
              child: TextFormField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value){
                    _submitSearchField();
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 16.0),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: 'Topic/keyword',
                      hintStyle: bodyStyle(fontSize: 12.0),
                      suffixIcon: InkWell(
                          onTap: (){
                            _submitSearchField();
                          },
                          child: Icon(Icons.search)
                      )
                  ),
                  validator: (value) =>
                  (value.isEmpty) ? "Topic/keyword can't be empty" : null
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    LeapsAssetWithText(
                      needsDecoration: false,
                      isHorizontal: true,
                      hPadding: 0.0,
                      customSpacer: 0.0,
                      isIcon: true,
                      text: AppState.userDetails.country,
                      textStyle: bodyStyle(
                        fontColor: AppColors.Black,
                        fontSize: AppDimensions.dimenTwelve,
                      ),
                      iconData: Icons.location_on,
                      iconColor: AppColors.Red,
                      iconSize: 20,
                    ),
                    AppDimensions.horizontalSpacer(),
                    LeapsAssetWithText(
                      needsDecoration: false,
                      isHorizontal: true,
                      hPadding: 0.0,
                      customSpacer: 0.0,
                      isIcon: true,
                      text: selectedSubject == null ? 'Subject is empty' : '$selectedSubject',
                      textStyle: bodyStyle(
                        fontColor: AppColors.Black,
                        fontSize: AppDimensions.dimenTwelve,
                      ),
                      iconData: Icons.subject,
                      iconColor: AppColors.Purple,
                    ),
                  ],
                ),
                /*Spacer(),
                InkWell(
                  onTap: (){},
                  child: SvgPicture.asset(
                    AppSVGs.Filter,
                    width: 18,
                    height: 18,
                    color: AppColors.Purple,
                  ),
                )*/
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
