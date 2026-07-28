import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/HomePage/Model/home_page_model.dart';

class HomePageController {
  final apiManager = ApiManager();
  final appSettingUrl = AppConstant.baseUrl + '/app_settings';
  //: get app data
  Future<HomePageModel> getAppData() {
    final response = apiManager.request(
        appSettingUrl, null, null, 1, (json) => HomePageModel.fromJson(json));
    print(response);
    return response;
  }
}
