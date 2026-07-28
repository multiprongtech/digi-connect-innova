import 'package:digi_connect/ApiManager/api_manager.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/VideosPage/Model/BGImage_model.dart';
import 'package:digi_connect/VideosPage/View/video_template_final_preview.dart';
import 'package:digi_connect/VideosPage/View/video_template_processing_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoImageOverlayController {
  var selectedImage = Rxn<XFile>();
  var videoUrl = '';

//get bg image from api
  Future<BGImageModel> getTemplateData() {
    final apiManager = ApiManager();

    final appSettingUrl = AppConstant.baseUrl + '/backgroundlist';
    final response = apiManager.request(
        appSettingUrl, null, null, 1, (json) => BGImageModel.fromJson(json));
    print(response);
    return response;
  }

  //: gallery image
  pickImageFromGallery(VideoPlayerController plyrCtrl) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = XFile(pickedFile.path);
        if (selectedImage.value == null) {
          return;
        } else {
          _showProcessingPage(plyrCtrl);
        }
      }
    } catch (err) {
      print(err);
    }
  }

//: show processing page
  _showProcessingPage(VideoPlayerController plyrCtrl) {
    Get.bottomSheet(
      VideoTemplateProcessingPage(
        videoUrl: videoUrl,
        image: selectedImage.value!,
        plyrCtrl: plyrCtrl,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ).then((value) {
      Get.to(
        VideoTemplatePreviewPage(videoUrl: value as String),
      );
    });
  }

//: image from camera
  captureImage(VideoPlayerController plyrCtrl) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = XFile(pickedFile.path);
    }
  }

//: bottomsheet
  showBottomSheetWithOption(
      BuildContext context, int index, VideoPlayerController plyrCtrl) {
    Get.bottomSheet(
      Container(
        height: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                'Choose Option Below',
                style: AppTextStyles.title(context),
              ),
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: ElevatedButton(
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                onPressed: () {
                  pickImageFromGallery(plyrCtrl);
                  Get.back();
                },
                child: Text(
                  'Gallery',
                  style: AppTextStyles.mediumTitle(context),
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: ElevatedButton(
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Camera',
                  style: AppTextStyles.mediumTitle(context),
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: ElevatedButton(
                style: AppTheme.grayThemeStyle(),
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: AppTextStyles.mediumTitle(context),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
