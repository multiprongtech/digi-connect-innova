import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:get/get.dart';

//: home row
class VideoTemplatePreviewHeader extends StatelessWidget {
  VideoTemplatePreviewHeader(
      {super.key, required this.share, required this.pausePlayer});
  Function share;
  Function pausePlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              pausePlayer();
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
          ElevatedButton(
            style: AppTheme.lightTheme.elevatedButtonTheme.style,
            onPressed: () {
              share();
            },
            child: Text(
              'Share Now',
              style: AppTextStyles.title(context),
            ),
          ),
        ],
      ),
    );
  }
}
