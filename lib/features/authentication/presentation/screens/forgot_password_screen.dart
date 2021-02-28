import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leaps/core/base/leaps_base_change_notifier.dart';
import 'package:leaps/core/components/leaps_button.dart';
import 'package:leaps/core/components/leaps_loading_indicators.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/core/constants/leaps_strings.dart';
import 'package:leaps/core/themes/leaps_colors.dart';
import 'package:leaps/core/themes/leaps_text_style.dart';
import 'package:leaps/features/authentication/domain/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController(text: "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: BaseChangeNotifierProvider<AuthViewModel>(
          model: AuthViewModel(authService: Provider.of(context)),
          builder: (context, model, child) => LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: AppEdgeInsets.allSixteen,
                  width: constraint.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppDimensions.verticalSpacer(spaceSize: 62.0),
                      SvgPicture.asset(
                        AppSVGs.forgot_password,
                        width: 130,
                        height: 130,
                      ),
                      AppDimensions.verticalSpacer(spaceSize: 48.0),
                      Text(
                        "Forgot password ?",
                        style: bodyStyle(
                            fontSize: 30,
                            fontColor: AppColors.Black
                        ),
                      ),
                      AppDimensions.verticalSpacer(spaceSize: 18.0),
                      Text(
                        'We just need your registered email address \n to send you password reset',
                        textAlign: TextAlign.center,
                        style: bodyStyle(
                          fontColor: AppColors.Black,
                        ),
                      ),
                      AppDimensions.verticalSpacer(spaceSize: 48.0),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                                labelText: 'Email',
                            ),
                            validator: (value) =>
                            (value.isEmpty) ? 'Please enter email' : null
                        )
                      ),
                      model.busy?
                      LeapsLoadIndicator.loadingPulse(20.0):
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppDimensions.dimenFourteen),
                        child: LeapsButton(
                          btnBak: AppColors.Purple,
                          btnWidth: constraint.maxWidth,
                          btnText: 'GET NEW PASSWORD',
                          marginTop: AppDimensions.dimenTwelve,
                          textColor: AppColors.White,
                          onPressed: () async {},
                        ),
                      ),
                      /*Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.dimenTwenty,
                            horizontal: AppDimensions.dimenEight),
                        child: Column(
                          children: <Widget>[

                          ],
                        ),
                      ),*/
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }
}
