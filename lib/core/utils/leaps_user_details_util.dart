import 'package:leaps/features/authentication/data/models/user.dart';

class AppState {
  static User _user;

  static setUser(User user) {
    _user = user;
  }

  static User get userDetails => _user;
}
