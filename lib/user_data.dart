import 'package:digi_connect/LoginPage/Model/login_model.dart';

class UserData {
  static final UserData _singleton = UserData._internal();

  LoginData? userData;

  factory UserData() {
    return _singleton;
  }

  UserData._internal() {
    // initialize your singleton instance
  }
}
