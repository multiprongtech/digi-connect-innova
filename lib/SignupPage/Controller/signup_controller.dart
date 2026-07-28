import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/SignupPage/Model/signup_model.dart';
import 'package:get/get.dart';

class SignupController {
  var isPasswordVisible = false.obs;
  final apiManager = ApiManager();
  final registerUrl = AppConstant.baseUrl + '/register';

  //: register
  Future<SignupModel> registerRequest(Map<String, Object> param) async {
    final response = await apiManager.request(
        registerUrl, null, param, 2, (json) => SignupModel.fromJson(json));
    return response;
  }
}
