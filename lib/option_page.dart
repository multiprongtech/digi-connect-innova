import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/OnboardPage/onboard_page.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'HomePage/View/home_page.dart';
import 'OnboardPage/onboard_controller.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

//: check for ios
  _checkForiOSTheme() async {
    final themeType = await OnBoardController().retrieveiOSTheme();
    if (themeType != null) {
      AppConstant.selectedOption = themeType;
      _checkForAutoLogin();
    }
  }

//check for auto login
  _checkForAutoLogin() async {
    final user = await OnBoardController().retrievePerson();
    if (user != null) {
      UserData().userData = user;
      Get.offAll(HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Padding(padding: EdgeInsets.only(top: 64)),
            Text(
              'Choose Division',
              style: AppTextStyles.headLine(context),
            ),
            AppTextStyles.blankHeight(height: 16),
            SizedBox(
              width: Get.width * 0.5,
              child: ElevatedButton(
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                onPressed: () {
                  AppConstant.selectedOption = 1;
                  OnBoardController().saveLoginThemeForiOS(1);
                  Get.to(OnboardPage());
                },
                child: Text(
                  'Innova',
                  style: AppTextStyles.boldTitle(context),
                ),
              ),
            ),
            AppTextStyles.blankHeight(height: 16),
            SizedBox(
              width: Get.width * 0.5,
              child: ElevatedButton(
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                onPressed: () {
                  AppConstant.selectedOption = 2;
                  OnBoardController().saveLoginThemeForiOS(2);
                  Get.to(OnboardPage());
                },
                child: Text(
                  'Innovex',
                  style: AppTextStyles.boldTitle(context),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
