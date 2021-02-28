import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingHelper{
  static Future<bool> getOnBoardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool("onboarding_status") ?? false;
    return status;
  }

  static setOnBoardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('onboarding_status', true);
  }
}