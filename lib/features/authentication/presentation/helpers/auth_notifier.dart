import 'package:flutter/widgets.dart';
import 'package:leaps/features/authentication/data/models/user.dart';

class AuthNotifier with ChangeNotifier{
  User _user;
  String _country;
  String _password;

  bool _showCountryName = false;

  ///
  User get getUser => _user;
  String get getCountry => _country;
  String get getPassword => _password;

  bool get getShowCountryName => _showCountryName;

  ///
  setUser(User value) {
    _user = value;
    notifyListeners();
  }

  ///
  setCountry(String value) {
    _country = value;
    notifyListeners();
  }

  setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  ///
  setShouldCountryNameShow({bool value}){
    _showCountryName = value;
    notifyListeners();
  }
}