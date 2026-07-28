import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:digi_connect/user_data.dart';

class ProfilePageController {
  final apiManager = ApiManager();
  final appSettingUrl =
      AppConstant.baseUrl + '/delete_user/${UserData().userData?.userId}';
  //: get app data
  Future<HomePageModel> deleteUser() {
    final response = apiManager.request(
        appSettingUrl, null, null, 1, (json) => HomePageModel.fromJson(json));
    print(response);
    return response;
  }
}
