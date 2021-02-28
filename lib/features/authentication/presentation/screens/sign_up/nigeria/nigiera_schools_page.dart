import 'package:flutter/material.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/app_loader_spinkit.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/components/leaps_snackbar_content.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/authentication/data/models/user.dart';
import 'package:leaps/features/authentication/domain/view_models/auth_viewmodel.dart';
import 'package:leaps/features/authentication/domain/view_models/regions_viewmodel.dart';
import 'package:leaps/features/authentication/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:leaps/features/authentication/presentation/widgets/school_class_item.dart';
import 'package:provider/provider.dart';

import 'nigeria_classes_page.dart';

class SchoolsPage extends StatelessWidget {
  final User user;
  final String password;
  SchoolsPage({@required this.user, @required this.password});

  @override
  Widget build(BuildContext context) {
    print("Country in school: ${user.country}");
    bool isSelected = false;
    String selectedSchool;

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          NewSignUpScreen(
            pageTitle: 'Select a\nschool',
            pageIndex: 2,
            isStudent: user.isStudent,
            page: BaseChangeNotifierProvider<RegionViewModel>(
              model: RegionViewModel(region: Provider.of(context)),
              onModelReady: (regionModel) => regionModel.fetchSchools(user.country),
              builder: (context, regionModel, child) => LayoutBuilder(
                  builder: (context, constraint) {
                    switch (regionModel.viewStateGet) {
                      case ViewStateGet.Loading:
                        return Container(
                          height: AppDimensions.screenHeight(context) / 2,
                          child: LeapsLoadIndicator.loadingPulse(40.0),
                        );
                      case ViewStateGet.hasData:
                        return ChangeNotifierProvider<ValueNotifier<int>>(
                            builder: (selectedSchoolIndex) => ValueNotifier<int>(null),
                            child: Consumer<ValueNotifier<int>>(
                              builder: (context, selectedSchoolIndex, child) =>
                                  Container(
                                    height: AppDimensions.screenHeight(context),
                                    child: GridView.builder(
                                        physics: ScrollPhysics(),
                                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2
                                        ),
                                        itemCount: regionModel.schools.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          isSelected = selectedSchoolIndex.value == index;
                                          return GestureDetector(
                                            onTap: (){
                                              selectedSchoolIndex.value = index;
                                              isSelected = selectedSchoolIndex.value == index;
                                              selectedSchool = regionModel.schools[index];
                                              print('Selected school name is: ${regionModel.schools[index]}');
                                            },
                                            child: SchoolClassItem(
                                              text: regionModel.schools[index],
                                              isSelected: isSelected,
                                            ),
                                          );
                                        }),
                                  ),
                            )
                        );
                      case ViewStateGet.Empty:
                        return Text(
                          "We don't have schools for your regions yet",
                          style: bodyStyle(),
                        );
                      case ViewStateGet.Error:
                        return Container(
                          child: Center(
                            child: Text(
                                'An error occured'
                            ),
                          ),
                        );
                      default:
                        return Container();
                    }
                  }),
            ),
          ),
          BaseChangeNotifierProvider<AuthViewModel>(
            model: AuthViewModel(authService: Provider.of(context)),
            builder: (context, authModel, __) => Align(
              alignment: Alignment.bottomCenter,
              child: authModel.busy?
              Container(
                  width: AppDimensions.screenWidth(context),
                  height: 60,
                  child: BtnSpinKit(
                      marginTop: AppDimensions.dimenTwelve)):
              LeapsButton(
                btnBak: AppColors.Purple,
                btnHeight: 60,
                btnWidth: AppDimensions.screenWidth(context),
                btnText: user.isStudent == true ? 'CONTINUE' : 'SIGN UP',
                marginTop: AppDimensions.dimenTwelve,
                textColor: AppColors.White,
                onPressed: () async{
                  if(selectedSchool == null){
                    LeapsSnackbar(
                        context: context,
                        snackBarText: "School can't be empty",
                        messageType: MessageType.Error,
                        globalKey: _scaffoldKey
                    );
                    return;
                  }else{
                    print('object $selectedSchool');
                    Map<String, dynamic> userSchool = {UserConstants.SCHOOL_NAME: selectedSchool};
                    final finalUserDetails = {
                      ...user.dataToMap(),
                      ...userSchool,
                    };
                    user.isStudent == true ? LeapsAppNavigator(
                        context: context,
                        page: ClassesPage(user: user, password: password, school: selectedSchool)
                    ) :
                    await authModel.signUp(
                      context: context,
                      data: finalUserDetails,
                      password: password,
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
