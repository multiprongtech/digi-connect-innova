import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextFields.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/SignupPage/Controller/signup_controller.dart';
import 'package:digi_connect/SignupPage/Vieiw/signup_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controller = SignupController();
  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  final regionCtrl = TextEditingController();
  final hqCtrl = TextEditingController();

//: register request
  registrationRequest() async {
    /*if (nameCtrl.text.isEmpty ||
        mobileCtrl.text.isEmpty ||
        pswdCtrl.text.isEmpty ||
        hqCtrl.text.isEmpty ||
        regionCtrl.text.isEmpty) {
      AppConstant.showSnackBar("Alert", "All fields are required.");
    } else {*/
    final param = {
      'name': nameCtrl.text,
      'mobile_no': mobileCtrl.text,
      'emp_code': pswdCtrl.text,
      'hq': hqCtrl.text,
      'region': regionCtrl.text,
    };

    AppConstant.showSnackBar(
        "Processing...", "Please wait your request is in process");

    final response = await controller.registerRequest(param);

    if (response.status == 200) {
      AppConstant.showSnackBar(
          "Success", response.message ?? 'Registration process done.');
    } else {
      AppConstant.showSnackBar(
          "Alert", response.message ?? 'Something went wrong');
    }
    //}
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
                      'Sign up',
                      style: AppTextStyles.headLine(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
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
                            'Sign up with Mobile',
                            style: AppTextStyles.heavyTitle(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppTextStyles.blankHeight(height: 24),
                  TextField(
                    decoration: AppTextFields.roundedBorder(
                      hintText: 'Name',
                    ),
                    controller: nameCtrl,
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
                      obscureText: controller.isPasswordVisible.value,
                      controller: pswdCtrl,
                    );
                  }),
                  AppTextStyles.blankHeight(height: 24),
                  TextField(
                    decoration: AppTextFields.roundedBorder(
                      hintText: 'Mobile Number',
                    ),
                    keyboardType: TextInputType.phone,
                    controller: mobileCtrl,
                  ),
                  AppTextStyles.blankHeight(height: 24),
                  TextField(
                    decoration: AppTextFields.roundedBorder(
                      hintText: 'Headquater',
                    ),
                    controller: hqCtrl,
                  ),
                  AppTextStyles.blankHeight(height: 24),
                  TextField(
                    decoration: AppTextFields.roundedBorder(
                      hintText: 'Region',
                    ),
                    controller: regionCtrl,
                  ),
                  AppTextStyles.blankHeight(height: 24),
                  SizedBox(
                    width: Get.width * 0.85,
                    height: 45,
                    child: ElevatedButton(
                      style: AppTheme.lightTheme.elevatedButtonTheme.style,
                      onPressed: () {
                        //Get.off(SignupConfirmationPage());
                        registrationRequest();
                      },
                      child: Text(
                        'Sign Up',
                        style: AppTextStyles.subTitle(context),
                      ),
                    ),
                  ),
                  AppTextStyles.blankHeight(height: 16),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: AppTextStyles.heavyTitle(context),
                        ),
                        AppTextStyles.blankWidth(),
                        Text(
                          'Sign in',
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
