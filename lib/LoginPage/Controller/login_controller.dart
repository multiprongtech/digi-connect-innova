import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/LoginPage/Model/login_model.dart';
import 'package:get/get.dart';

class LoginController {
  var isPasswordVisible = false.obs;
  final apiManager = ApiManager();
  final loginUrl = AppConstant.baseUrl + '/login';

//: login request
  Future<LoginModel> loginRequest(Map<String, Object> param) async {
    final response = await apiManager.request(
        loginUrl, null, param, 2, (json) => LoginModel.fromJson(json));

    return response;
  }
}
