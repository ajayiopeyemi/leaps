import 'package:flutter/material.dart';
import 'package:leaps/core/components/app_loader_spinkit.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/features/authentication/data/services/auth_service.dart';
import 'package:leaps/features/authentication/domain/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../forgot_password_screen.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _email;
  TextEditingController _password;

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    void _togglePasswordVisibility() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    final AuthService auth = Provider.of<AuthService>(context);
    return ChangeNotifierProvider<AuthViewModel>(
      builder: (_) => AuthViewModel(authService: auth),
      child: Consumer<AuthViewModel>(
        builder: (context, model, child) =>
            LayoutBuilder(builder: (context, constraint) {
          final height = constraint.maxHeight;
          final width = constraint.maxWidth;

          return Container(
            child: Padding(
              padding: AppEdgeInsets.allTwentyFour,
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.dimenTwelve,
                            horizontal: AppDimensions.dimenEight),
                        child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: AppColors.Purple,
                                )),
                            validator: (value) =>
                                (value.isEmpty) ? 'Please enter email' : null),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppDimensions.dimenTwelve,
                              horizontal: AppDimensions.dimenEight),
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
                                          )),
                              ),
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value.length < 6) {
                                  return 'Password should be 6 digits or more';
                                } else {
                                  return null;
                                }
                              })),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ForgotPasswordScreen()));
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 8.0),
                          child: new Text(
                            'Forgot Password ?',
                            style: TextStyle(
                                color: AppColors.PrimaryColor, fontSize: 12),
                          ),
                        ),
                      ),
                      model.busy
                          ? Container(
                              width: width,
                              child: BtnSpinKit(
                                  marginTop: AppDimensions.dimenTwelve))
                          : Container(
                              width: width,
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.dimenSixteen,
                                  horizontal: AppDimensions.dimenEight),
                              child: LeapsButton(
                                  btnBak: AppColors.Purple,
                                  btnWidth: 50.0,
                                  btnText: 'Sign In',
                                  marginTop: AppDimensions.dimenTwelve,
                                  textColor: AppColors.White,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await model.signIn(
                                          context,
                                          _email.text,
                                          _password.text
                                      );
                                    }
                                  })
                      )
                    ],
                  )),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
