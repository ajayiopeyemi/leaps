import 'package:flutter/material.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/components/leaps_custom_drop_down_field.dart';
import 'package:leaps/core/components/leaps_snackbar_content.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/enums/leaps_type_enums.dart';
import 'package:leaps/core/navigation/leaps_navigator.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/authentication/data/models/user.dart';
import 'package:leaps/features/authentication/presentation/helpers/auth_notifier.dart';
import 'package:leaps/features/authentication/presentation/screens/sign_up/nigeria/nigiera_schools_page.dart';
import 'package:leaps/features/authentication/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:provider/provider.dart';

class PersonalDetailsForm extends StatefulWidget {
  final bool isTeacher;
  PersonalDetailsForm({@required this.isTeacher});
  @override
  _PersonalDetailsFormState createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  TextEditingController _firstName;
  TextEditingController _surname;
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _rePassword;

  final _formKey = GlobalKey<FormState>();
  bool _obscureText;
  bool _isStudent;
  bool _isUserVerified;

  @override
  void didChangeDependencies() {
    Provider.of<AuthNotifier>(context, listen: false).getCountry;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _obscureText = true;

    ///if the user is a teacher then the value of student will be false
    widget.isTeacher == true ? _isStudent = false : _isStudent = true;
    widget.isTeacher == true ? _isUserVerified = false : _isUserVerified = true;
    
    _firstName = TextEditingController(text: "");
    _surname = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _rePassword = TextEditingController(text: "");
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    var selectedCountry =
        Provider.of<AuthNotifier>(context, listen: false).getCountry;
    var shouldCountryNameShow =
        Provider.of<AuthNotifier>(context).getShowCountryName;

    final thisScreenPadding = EdgeInsets.symmetric(
        vertical: AppDimensions.dimenTwelve,
        horizontal: AppDimensions.dimenEight);

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          NewSignUpScreen(
            pageTitle: 'Personal\nDetails',
            pageIndex: 1,
            isStudent: _isStudent,
            page: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ///First name & surname
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: thisScreenPadding,
                              child: TextFormField(
                                  controller: _firstName,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                  ),
                                  keyboardType: TextInputType.text,
                                  autocorrect: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  }
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: thisScreenPadding,
                              child: TextFormField(
                                  controller: _surname,
                                  decoration: InputDecoration(
                                    labelText: 'Surname',
                                  ),
                                  keyboardType: TextInputType.text,
                                  autocorrect: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  }
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ///Email field
                    Padding(
                      padding: thisScreenPadding,
                      child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              suffixIcon: Icon(
                                Icons.email,
                                color: AppColors.Purple,
                              )),
                          keyboardType: TextInputType.emailAddress,
                          autovalidate: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          }
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ///Country field
                    LeapsCustomDropDownField(
                        items: country,
                        useCase: RegistrationUseCase.Country,
                        isCountryNull: shouldCountryNameShow
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                        padding: thisScreenPadding,
                        child: TextFormField(
                            controller: _password,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    _togglePasswordVisibility();
                                  },
                                  child: _obscureText
                                      ? Icon(
                                    Icons.visibility_off,
                                    color: AppColors.Purple,
                                  )
                                      : Icon(
                                    Icons.visibility,
                                    color: AppColors.Purple,
                                  )
                              ),
                            ),
                            obscureText: _obscureText,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length < 6) {
                                return 'Password should be 6 digits or more';
                              } else {
                                return null;
                              }
                            })),
                    ///Confirm password field
                    Padding(
                      padding: thisScreenPadding,
                      child: TextFormField(
                        controller: _rePassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autocorrect: false,
                        validator: (value) {
                          if (_password.text != value) {
                            return 'Password do not match';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    AppDimensions.verticalSpacer(spaceSize: 30.0)
                  ],
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LeapsButton(
              btnWidth: AppDimensions.screenWidth(context),
              btnBak: AppColors.Purple,
              btnText: 'Continue',
              marginTop: AppDimensions.dimenTwelve,
              textColor: AppColors.White,
              onPressed: () async {
                print('Selected country is $selectedCountry');
                User userDetails = User(
                    avatar: '',
                    firstName: _firstName.text,
                    surname: _surname.text,
                    email: _email.text,
                    isStudent: _isStudent,
                    isUserVerified: _isUserVerified,
                    country: selectedCountry
                );
                print('Should country show: $shouldCountryNameShow');
                if (selectedCountry == null || (shouldCountryNameShow == false || shouldCountryNameShow == null)) {
                  LeapsSnackbar(
                      context: context,
                      snackBarText: "Country can't be empty",
                      messageType: MessageType.Error,
                      globalKey: _scaffoldKey
                  );
                  return;
                }else{
                  ChangeNotifierProvider<AuthNotifier>.value(
                      value: Provider.of<AuthNotifier>(context).setUser(userDetails)
                  );
                  if (_formKey.currentState.validate()) {
                    LeapsAppNavigator(
                        context: context,
                        page: SchoolsPage(user: userDetails, password: _password.text,)
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    _rePassword.dispose();
    super.dispose();
  }
}
