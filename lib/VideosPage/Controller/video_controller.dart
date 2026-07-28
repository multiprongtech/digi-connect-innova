import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/ImagePage/Model/ImageTemplateModel.dart';

class VideoPageController {
  Future<ImageTemplateModel> getTemplateData(int cat_id) {
    final apiManager = ApiManager();
    final appSettingUrl =
        AppConstant.baseUrl + '/productsAvailabilitylist?category=$cat_id';
    final response = apiManager.request(appSettingUrl, null, null, 1,
        (json) => ImageTemplateModel.fromJson(json));
    print(response);
    return response;
  }
}
