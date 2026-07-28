import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class FormPageController {
  var image1 = Rxn<XFile>();
  var image2 = Rxn<XFile>();

  //: gallery image
  pickImageFromGallery(int selectedImageFor) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (selectedImageFor == 1) {
          image1.value = XFile(pickedFile.path);
        } else {
          image2.value = XFile(pickedFile.path);
        }
      }
    } catch (err) {
      print(err);
    }
  }

//: image from camera
  captureImage(int selectedImageFor) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (selectedImageFor == 1) {
        image1.value = XFile(pickedFile.path);
      } else {
        image2.value = XFile(pickedFile.path);
      }
    }
  }

//: bottomsheet
  showBottomSheetWithOption(BuildContext context, int index) {
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
                  Get.back();
                  pickImageFromGallery(index);
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
                  captureImage(index);
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
