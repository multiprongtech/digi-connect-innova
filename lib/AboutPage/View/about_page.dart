import 'package:digi_connect/AboutPage/View/about_page_header.dart';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/SideMenuPage/View/side_menu_page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void menuTapped() {
    drawerKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutPageHeader(
          menuTapped: menuTapped,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListView(
              children: [
                Text(
                  'Introducing DIGI CONNECT INNOVA - The Ultimate Personalized Greeting Card Experience!\n\nJoin us on a journey of creativity and heartfelt connections. With DIGI CONNECT INNOVA, you can unleash your imagination and create beautiful personalized e-greetings like never before.\n\n-- Register and login seamlessly to unlock a world of endless possibilities.\n\n-- On the dynamic dashboard, explore an array of vibrant categories, including birthday cards, anniversary cards, brand cards, and more. The choice is yours!\n\n-- Dive into each category to discover a captivating collection of stunning templates. From elegant to playful, find the perfect design that resonates with your sentiments.\n\n-- Customize your chosen template effortlessly by adding the essential information that makes it uniquely yours. Whether it\'s a heartfelt message, a special quote, or personalized details, let your creativity shine through.\n\n-- With a simple tap, watch as the template magically comes to life, blending seamlessly with your personalized information. The result? A truly one-of-a-kind e-greeting that reflects your heartfelt emotions.\n\n-- Share your personalized masterpiece with loved ones near and far through various sharing options. Spread joy, laughter, and warm wishes with just a few clicks.\n\nWith DIGI CONNECT INNOVA, your greetings transcend the ordinary, leaving a lasting impression on the hearts of those you cherish. Experience the power of personalization and celebrate every occasion with creativity and love.',
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
