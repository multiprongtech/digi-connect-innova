import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/ImagePage/Model/ImageTemplateModel.dart';

class ImagePageController {
  final apiManager = ApiManager();

  Future<ImageTemplateModel> getTemplateData(int cat_id) {
    final appSettingUrl =
        AppConstant.baseUrl + '/productsAvailabilitylist?category=$cat_id';
    final response = apiManager.request(appSettingUrl, null, null, 1,
        (json) => ImageTemplateModel.fromJson(json));
    print(response);
    return response;
  }

//saveShare data to server
  saveShareDataToServer(Map<String, dynamic> body) {
    final appSettingUrl = AppConstant.baseUrl + '/activity';

    final response = apiManager.request(appSettingUrl, null, body, 2,
        (json) => ImageTemplateModel.fromJson(json));
    print(response);
  }
}
