import 'dart:async';

import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/VideosPage/Controller/video_merge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class VideoTemplateProcessingPage extends StatefulWidget {
  VideoTemplateProcessingPage(
      {super.key,
      required this.videoUrl,
      required this.image,
      required this.plyrCtrl});
  String videoUrl;
  XFile image;
  VideoPlayerController plyrCtrl;
  @override
  State<VideoTemplateProcessingPage> createState() =>
      _VideoTemplateProcessingPageState();
}

class _VideoTemplateProcessingPageState
    extends State<VideoTemplateProcessingPage> {
  final _controller = VideoMergeController();
  late VideoPlayerController _player;
  var percentage = 0.0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.imgPath.value = widget.image.path;
    _controller.downloadVideoFrom(widget.videoUrl, widget.plyrCtrl);
    _updatePercentage();
  }

  _updatePercentage() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (percentage.value == 100) {
        timer.cancel();
      }
      percentage.value = _controller.updatedVideoPath.value.isEmpty
          ? ((percentage.value < 96) ? percentage.value + 2.2 : 0)
          : 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Obx(() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "Processing...",
                style: AppTextStyles.boldTitle(context),
              ),
              SizedBox(
                height: 16,
              ),
              _controller.updatedVideoPath.value.isEmpty
                  ? LinearProgressIndicator(
                      value: percentage.value / 100.0,
                    )
                  : Text('Complete'),
              Spacer(),
            ],
          ),
        );
      }),
    );
  }
}
