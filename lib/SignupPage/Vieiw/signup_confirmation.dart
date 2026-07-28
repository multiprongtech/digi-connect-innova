import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupConfirmationPage extends StatelessWidget {
  const SignupConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              SizedBox(
                width: Get.width * 0.4,
                child: const Image(
                  image: AssetImage(AppConstant.checkCircleImage),
                  fit: BoxFit.fitWidth,
                ),
              ),
              AppTextStyles.blankHeight(height: 16),
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  'Thank you! For Sign Up Your Request is Submitted Successfully',
                  style: AppTextStyles.heading1(context),
                  textAlign: TextAlign.center,
                ),
              ),
              AppTextStyles.blankHeight(
                height: 32,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Back',
                  style: AppTextStyles.heavyTitle(context),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
