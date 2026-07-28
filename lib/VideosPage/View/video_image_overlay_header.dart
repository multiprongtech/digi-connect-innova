import 'package:digi_connect/VideosPage/View/video_image_overlay.dart';
import 'package:flutter/material.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:get/get.dart';

//: home row
class VideoImageOverlayHeader extends StatelessWidget {
  const VideoImageOverlayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              selectedVideoPlayerController = null;
              selectedVideoTemplate = null;
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          Text(
            'Video Greeting',
            style: AppTextStyles.title(context),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
