import 'package:digi_connect/AboutPage/View/about_page.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/HomePage/View/home_page.dart';
import 'package:digi_connect/LoginPage/View/login_page.dart';
import 'package:digi_connect/OnboardPage/onboard_controller.dart';
import 'package:digi_connect/option_page.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          Row(
            children: const [
              Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
                size: 100,
              ),
              Spacer(),
            ],
          ),
          Text(
            UserData().userData?.userName ?? ' - ',
            style: AppTextStyles.heading1_themecolor(context),
          ),
          AppTextStyles.blankHeight(height: 16),
          GestureDetector(
            onTap: () {
              menuType.value = 'home';
              drawerKey.currentState!.closeDrawer();
            },
            child: Text(
              'Home',
              style: AppTextStyles.heading2(context),
            ),
          ),
          AppTextStyles.blankHeight(height: 8),
          GestureDetector(
            onTap: () {
              drawerKey.currentState!.closeDrawer();
              if (UserData().userData == null) {
                Get.to(LoginPage());
              } else {
                menuType.value = 'profile';
              }
            },
            child: Text(
              'Profile',
              style: AppTextStyles.heading2(context),
            ),
          ),
          AppTextStyles.blankHeight(height: 8),
          GestureDetector(
            onTap: () {
              menuType.value = 'about';
              drawerKey.currentState!.closeDrawer();
            },
            child: Text(
              'About',
              style: AppTextStyles.heading2(context),
            ),
          ),
          AppTextStyles.blankHeight(height: 8),
          GestureDetector(
            onTap: () {
              menuType.value = 'privacy';
              drawerKey.currentState!.closeDrawer();
            },
            child: Text(
              'Privacy Policy',
              style: AppTextStyles.heading2(context),
            ),
          ),
          AppTextStyles.blankHeight(height: 8),
          GestureDetector(
            onTap: () {
              menuType.value = 'help';
              drawerKey.currentState!.closeDrawer();
            },
            child: Text(
              'Help Center',
              style: AppTextStyles.heading2(context),
            ),
          ),
          AppTextStyles.blankHeight(height: 8),
          (UserData().userData == null)
              ? Text('')
              : GestureDetector(
                  onTap: () {
                    menuType.value = 'home';
                    OnBoardController().removeLoginData();
                    OnBoardController().removeiOSSaveTheme();
                    drawerKey.currentState!.closeDrawer();
                    Get.offAll(OptionPage());
                  },
                  child: Text(
                    'Logout',
                    style: AppTextStyles.heading2(context),
                  ),
                ),
        ],
      ),
    );
  }
}
