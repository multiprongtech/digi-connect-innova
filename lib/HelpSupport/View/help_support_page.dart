import 'package:digi_connect/AboutPage/View/about_page_header.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/HelpSupport/View/help_support_header.dart';
import 'package:digi_connect/PrivacyPolicyPage/privacy_policy_header.dart';
import 'package:digi_connect/SideMenuPage/View/side_menu_page.dart';
import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  void menuTapped() {
    drawerKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HelpAndSupportHeader(
          menuTapped: menuTapped,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListView(
              children: [
                AppTextStyles.blankHeight(height: 32),
                Icon(
                  Icons.headset_mic_rounded,
                  size: 100,
                ),
                Text(
                  'Customer Support',
                  style: AppTextStyles.heading1(context),
                  textAlign: TextAlign.center,
                ),
                AppTextStyles.blankHeight(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_android,
                      size: 30,
                    ),
                    Text(
                      '+919998121432',
                      style: AppTextStyles.title(context),
                    ),
                  ],
                ),
                AppTextStyles.blankHeight(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail,
                      size: 30,
                    ),
                    Text(
                      'itsupport@thecreativesense.com',
                      style: AppTextStyles.title(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
