import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstant {
  static const appThemeColor = Color.fromRGBO(254, 193, 7, 1);
  static const textFieldBgColor = Color.fromARGB(179, 240, 240, 240);
  static const iconColor = Color.fromARGB(179, 201, 201, 201);

  static const checkCircleImage = "Assets/Images/CheckCircle.png";
  static const iconVideo = "Assets/Images/icon_video_circle.png";
  static const onboardImage = "Assets/Images/connected_world-cuate.png";
  static const bottomRefresh = "Assets/Images/bottom_refresh.png";
  static var selectedOption = 1;
  static get baseUrl {
    return (selectedOption == 1)
        ? 'https://acers.multiprong.com/apis'
        : 'http://ipcainnovex.csplclient.in/apis';
  }

  static showSnackBar(String title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: Duration(seconds: 3),
      ),
    );
  }
}

GlobalKey<ScaffoldState> drawerKey = GlobalKey();
