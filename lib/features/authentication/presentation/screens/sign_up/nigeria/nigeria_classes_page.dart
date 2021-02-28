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
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/authentication/data/models/user.dart';
import 'package:leaps/features/authentication/domain/view_models/auth_viewmodel.dart';
import 'package:leaps/features/authentication/domain/view_models/regions_viewmodel.dart';
import 'package:leaps/features/authentication/presentation/widgets/school_class_item.dart';
import 'package:provider/provider.dart';

import '../sign_up_screen.dart';

class ClassesPage extends StatelessWidget {
  final User user;
  final String password;
  final String school;
  ClassesPage({
    @required this.user,
    @required this.password,
    @required this.school
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    String selectedClass;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          NewSignUpScreen(
            pageTitle: 'Select a\nclass',
            pageIndex: 3,
            isStudent: user.isStudent,
            page: BaseChangeNotifierProvider<RegionViewModel>(
              model: RegionViewModel(region: Provider.of(context)),
              onModelReady: (regionModel) => regionModel.fetchClasses(user.country),
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
                          builder: (selectedClassIndex) => ValueNotifier<int>(null),
                          child: Consumer<ValueNotifier<int>>(
                            builder: (context, selectedClassIndex, __) =>
                                Container(
                                  height: AppDimensions.screenHeight(context),
                                  child: GridView.builder(
                                      physics: ScrollPhysics(),
                                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                      itemCount: regionModel.classes.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        isSelected = selectedClassIndex.value == index;
                                        return GestureDetector(
                                          onTap: (){
                                            selectedClassIndex.value = index;
                                            isSelected = selectedClassIndex.value == index;
                                            selectedClass = regionModel.classes[index];
                                          },
                                          child: SchoolClassItem(
                                            text: regionModel.classes[index],
                                            isSelected: isSelected,
                                          ),
                                        );
                                      }),
                                ),
                          ),
                        );
                      case ViewStateGet.Empty:
                        return Text("We don't have schools for your regions yet");
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
            builder: (context, authModel, child) => Align(
              alignment: Alignment.bottomCenter,
              child: authModel.busy ?
              Container(
                  width: AppDimensions.screenWidth(context),
                  height: 60,
                  child: BtnSpinKit(
                      marginTop: AppDimensions.dimenTwelve)):
              LeapsButton(
                btnBak: AppColors.Purple,
                btnHeight: 60,
                btnWidth: AppDimensions.screenWidth(context),
                btnText: 'SIGN UP',
                marginTop: AppDimensions.dimenTwelve,
                textColor: AppColors.White,
                onPressed: () async{
                  if(selectedClass == null){
                    LeapsSnackbar(
                        context: context,
                        snackBarText: "Class can't be empty",
                        messageType: MessageType.Error,
                        globalKey: _scaffoldKey
                    );
                    return;
                  }else{
                    print('the password: $password');
                    Map<String, dynamic> userSchoolAndClass = {
                      UserConstants.SCHOOL_NAME: school,
                      UserConstants.CLASS: selectedClass
                    };
                    final finalUserDetails = {
                      ...user.dataToMap(),
                      ...userSchoolAndClass,
                    };
                    print(finalUserDetails);
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
