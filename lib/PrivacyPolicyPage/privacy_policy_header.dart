import 'package:digi_connect/HomePage/View/home_page.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';

//: home row
class PrivacyPolicyHeader extends StatelessWidget {
  PrivacyPolicyHeader({super.key, required this.menuTapped});

  Function menuTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            height: 50,
            child: GestureDetector(
              onTap: () {
                menuTapped();
              },
              child: Icon(
                Icons.menu,
                size: 30,
              ),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white70,
            ),
          ),
          Text(
            'Privacy Policy',
            style: AppTextStyles.title(context),
          ),
          GestureDetector(
            onTap: () {
              menuType.value = "profile";
            },
            child: Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.person,
                size: 30,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
