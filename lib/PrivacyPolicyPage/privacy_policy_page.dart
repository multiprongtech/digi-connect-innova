import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/PrivacyPolicyPage/privacy_policy_header.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  void menuTapped() {
    drawerKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrivacyPolicyHeader(
          menuTapped: menuTapped,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListView(
              children: [
                Text(
                  '''
Privacy Policy for Digiconnect Innova

Effective Date: May 1st, 2023

This Privacy Policy describes how Digiconnect Innova collects, uses, stores, and discloses personal information obtained from users of our mobile application. By using our app, you consent to the collection and processing of your personal data as described in this Privacy Policy.

Information We Collect:
1.1 User Registration Information: To create an account on Digiconnect Innova, we require you to provide a username, mobile number, email address, and password. This information is necessary for user authentication, account management, and personalized user experience.
1.2 Card Customization Information: When you use Digiconnect Innova to customize e-birthday cards, e-anniversary cards, or other festive templates, we may collect the names and photos you provide to personalize the templates. This information is solely used for generating the output templates and is not shared with third parties without your explicit consent.

Use of Information:
2.1 Personalization and Card Creation: The information you provide, such as names and photos, is used solely for the purpose of customizing templates and generating output cards. We do not use this information for any other purpose without your explicit permission.
2.2 Account Management: Your username, mobile number, and email address are used for managing your account, providing customer support, and sending important notifications related to your account or the app's services.
2.3 Analytics and Improvements: We may collect anonymous usage data, such as app usage statistics and user interactions, to analyze and improve the functionality and performance of [App Name]. This data is aggregated and does not personally identify you.

Data Storage and Security:
3.1 Data Retention: We retain your personal information as long as it is necessary to provide you with our services or as required by law. If you choose to delete your account, your personal data will be deleted from our active databases and backups within a reasonable timeframe.
3.2 Data Security: We implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, please be aware that no method of transmission or storage over the internet is 100% secure.

Sharing of Information:
4.1 Third-Party Service Providers: We may engage trusted third-party service providers to perform certain functions on our behalf, such as hosting, data analysis, and customer support. These providers have access to your personal information only to the extent necessary to fulfill their duties and are contractually obligated to maintain its confidentiality.
4.2 Legal Compliance and Protection: We may disclose your personal information if required by law, governmental request, or to protect the rights, property, or safety of [App Name], its users, or others.

Children's Privacy:
Digiconnect Innova does not knowingly collect personal information from children under the age of 13. If we become aware that we have collected personal information from a child without parental consent, we will take appropriate steps to delete it. If you believe that we may have inadvertently collected personal information from a child, please contact us immediately.

Updates to this Privacy Policy:
We reserve the right to update or modify this Privacy Policy at any time. If we make material changes, we will notify you through the app or via email. Please review this Privacy Policy periodically for any updates.

Contact Us:
If you have any questions, concerns, or requests regarding this Privacy Policy or the privacy practices of Digiconnect Innova, please contact us at ipca.development@gmail.com.
By using Digiconnect Innova, you acknowledge that you have read and understood this Privacy Policy and agree to the collection and processing of your personal information as described herein.
''',
                  textAlign: TextAlign.justify,
                  style: AppTextStyles.subTitle(context),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
