import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/HomePage/View/home_page.dart';
import 'package:digi_connect/LoginPage/View/login_page.dart';
import 'package:digi_connect/OnboardPage/onboard_controller.dart';
import 'package:digi_connect/SignupPage/Vieiw/signup_page.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAutoLogin();
  }

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
        child: ListView(
          children: [
            AppTextStyles.blankHeight(height: 24),
            Text(
              'Welcome to',
              style: AppTextStyles.headLine(context),
              textAlign: TextAlign.center,
            ),
            Image(
              image: AssetImage(
                (AppConstant.selectedOption == 1)
                    ? 'Assets/Images/textLogo.png'
                    : 'Assets/Images/textLogo1.png',
              ),
              width: Get.width * 0.3,
              height: 100,
            ),
            Image(
              image: AssetImage(AppConstant.onboardImage),
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              height: 45,
              child: ElevatedButton(
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                onPressed: () {
                  Get.to(LoginPage());
                },
                child: Text(
                  'Sign In',
                  style: AppTextStyles.subTitle(context),
                ),
              ),
            ),
            AppTextStyles.blankHeight(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              height: 45,
              child: ElevatedButton(
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                onPressed: () {
                  Get.to(RegisterPage());
                },
                child: Text(
                  'Sign Up',
                  style: AppTextStyles.subTitle(context),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(HomePage());
              },
              child: Text(
                'skip for now',
                style: AppTextStyles.skipStyle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
