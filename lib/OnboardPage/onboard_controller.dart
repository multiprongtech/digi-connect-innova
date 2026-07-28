import 'dart:convert';
import 'dart:ffi';

import 'package:digi_connect/LoginPage/Model/login_model.dart';
import 'package:digi_connect/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardController {
//Save Data
  void saveUserData(LoginData userData) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(userData.toJson());
    prefs.setString("user", userJson);
    print('Data saved $userJson');
  }

  Future<LoginData?> retrievePerson() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return LoginData.fromJson(userMap);
    } else {
      return null;
    }
  }

  void saveLoginThemeForiOS(int type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("iOSTheme", type);
    print('Data saved');
  }

  Future<int?> retrieveiOSTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getInt('iOSTheme');
    if (userJson != null) {
      return userJson;
    } else {
      return null;
    }
  }

  void removeiOSSaveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('iOSTheme');
    UserData().userData = null;
  }

  void removeLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    UserData().userData = null;
  }
}
