import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextFields.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/HomePage/View/home_page.dart';
import 'package:digi_connect/LoginPage/Controller/login_controller.dart';
import 'package:digi_connect/OnboardPage/onboard_controller.dart';
import 'package:digi_connect/SignupPage/Vieiw/signup_page.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = LoginController();
  final mobileCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  final isApiCall = false.obs;

  //: login api
  loginRequest() async {
    isApiCall.value = true;
    final param = {'mobile_no': mobileCtrl.text, 'password': pswdCtrl.text};
    final response = await controller.loginRequest(param);

    if (response.status != 200) {
      AppConstant.showSnackBar("Alert!", "${response.message}");
    } else {
      UserData().userData = response.data;
      OnBoardController().saveUserData(response.data!);
      drawerKey = GlobalKey();
      Get.offAll(HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width: Get.width,
              child: Row(
                children: [
                  AppTextStyles.blankWidth(width: 18),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.78,
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.headLine(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            AppTextStyles.blankHeight(height: 64),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 32,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Divider(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.white,
                          child: Text(
                            'Sign in with Mobile Number',
                            style: AppTextStyles.heavyTitle(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    decoration: AppTextFields.roundedBorder(
                      hintText: 'Mobile Number',
                    ),
                    keyboardType: TextInputType.phone,
                    controller: mobileCtrl,
                  ),
                  AppTextStyles.blankHeight(height: 24),
                  Obx(() {
                    return TextField(
                      decoration: AppTextFields.roundedBorder(
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.isPasswordVisible.value =
                                !controller.isPasswordVisible.value;
                          },
                          child: Icon(
                            (controller.isPasswordVisible.value)
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppConstant.iconColor,
                          ),
                        ),
                      ),
                      controller: pswdCtrl,
                      obscureText: controller.isPasswordVisible.value,
                    );
                  }),
                  // AppTextStyles.blankHeight(height: 16),
                  // Row(
                  //   children: [
                  //     Spacer(),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         'Forget Password?',
                  //         style: AppTextStyles.skipStyle(context),
                  //         textAlign: TextAlign.right,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  AppTextStyles.blankHeight(height: 24),
                  SizedBox(
                    width: Get.width * 0.85,
                    height: 45,
                    child: ElevatedButton(
                      style: AppTheme.lightTheme.elevatedButtonTheme.style,
                      onPressed: () {
                        //Get.offAll(HomePage());
                        loginRequest();
                      },
                      child: Text(
                        'Sign In',
                        style: AppTextStyles.subTitle(context),
                      ),
                    ),
                  ),
                  AppTextStyles.blankHeight(height: 16),
                  GestureDetector(
                    onTap: () {
                      Get.to(RegisterPage());
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: AppTextStyles.heavyTitle(context),
                        ),
                        AppTextStyles.blankWidth(),
                        Text(
                          'Sign UP',
                          style: AppTextStyles.heavyTitle(
                            context,
                            color: AppConstant.appThemeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
