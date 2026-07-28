import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:get/get.dart';

//: home row
class ImageTemplatePreviewHeader extends StatelessWidget {
  ImageTemplatePreviewHeader(
      {super.key, required this.share, required this.btnTitle});
  String btnTitle;

  Function share;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          Text(
            'Preview',
            style: AppTextStyles.title(context),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white70,
            ),
            child: ElevatedButton(
              style: AppTheme.lightTheme.elevatedButtonTheme.style,
              child: Text(
                '$btnTitle',
                style: AppTextStyles.boldTitle(context),
              ),
              onPressed: () {
                share();
              },
            ),
          ),
        ],
      ),
    );
  }
}
