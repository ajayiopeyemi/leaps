import 'package:flutter/material.dart';
import 'package:leaps/core/enums/leaps_state_enums.dart';

class LeapsBaseModel extends ChangeNotifier {
  AuthAccessStatus _accessStatus = AuthAccessStatus.Checking;
  AuthAccessStatus get authAccessStatus => _accessStatus;
  void setAuthStatus(AuthAccessStatus newState) {
    _accessStatus = newState;
    notifyListeners();
  }

  ViewStateCreate _statusCreate = ViewStateCreate.Creating;
  ViewStateCreate get viewStateCreate => _statusCreate;
  void setCreateState(ViewStateCreate newState) {
    _statusCreate = newState;
    notifyListeners();
  }

  ViewStateGet _statusGet = ViewStateGet.Loading;
  ViewStateGet get viewStateGet => _statusGet;
  void setGetState(ViewStateGet newState) {
    _statusGet = newState;
    notifyListeners();
  }

  bool _busy = false;
  bool get busy => _busy;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
