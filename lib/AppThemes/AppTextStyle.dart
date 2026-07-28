import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyles {
  static TextStyle skipStyle(BuildContext context) {
    return TextStyle(
      color: Colors.blueAccent,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      fontFamily: "Poppins",
    );
  }

  static TextStyle headLine(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
      height: 1.2,
    );
  }

  static TextStyle headLineNew(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 34,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
      height: 1.2,
    );
  }

  static TextStyle heading1(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
      height: 1.2,
    );
  }

  static TextStyle heading1_themecolor(BuildContext context) {
    return const TextStyle(
      color: AppConstant.appThemeColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
    );
  }

  static TextStyle heading2(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
    );
  }

  static TextStyle subTitle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: "Poppins",
    );
  }


  static TextStyle subTitleNew(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle title(BuildContext context, {Color? color = null}) {
    return TextStyle(
      color:
          color == null ? Theme.of(context).textTheme.bodyLarge?.color : color,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
    );
  }

  static TextStyle mediumTitle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
    );
  }

  static TextStyle boldTitle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
    );
  }

  static TextStyle heavyTitle(BuildContext context, {Color? color = null}) {
    return TextStyle(
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 16,
      fontWeight: FontWeight.w800,
      fontFamily: "Poppins",
    );
  }

  static TextStyle boldSubTitle(BuildContext context, {Color? color = null}) {
    return TextStyle(
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle mediumSubTitle(BuildContext context, {Color? color = null}) {
    return TextStyle(
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static SizedBox blankHeight({double height = 8.0}) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox blankWidth({double width = 8.0}) {
    return SizedBox(
      width: width,
    );
  }

  /* static Color lightBgColor(BuildContext context) {
    if (!Get.isDarkMode) {
      return Color.fromARGB(255, 248, 246, 246);
    }
    return Color.fromARGB(255, 59, 59, 59);
  }

  static Color lowLightBgColor(BuildContext context) {
    if (!Get.isDarkMode) {
      return Color.fromARGB(255, 231, 230, 230);
    }
    return Color.fromARGB(255, 18, 18, 18);
  } */
}
