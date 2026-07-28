import 'dart:io';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/VideosPage/Controller/video_merge_controller.dart';
import 'package:digi_connect/VideosPage/View/video_template_preview_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoTemplatePreviewPage extends StatefulWidget {
  VideoTemplatePreviewPage({super.key, required this.videoUrl});
  String videoUrl;

  @override
  State<VideoTemplatePreviewPage> createState() =>
      _VideoTemplatePreviewPageState();
}

class _VideoTemplatePreviewPageState extends State<VideoTemplatePreviewPage> {
  final _controller = VideoMergeController();
  VideoPlayerController? _player;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupPlayerInitialization();
  }

  _shareVideo() async {
    var isShared = await Share.shareXFiles([XFile(widget.videoUrl)]);
    if (isShared.status == ShareResultStatus.success) {
      print("siccess");
    } else {
      print("Failed to share");
    }
  }

//: show preview
  _setupPlayerInitialization() {
    _player = VideoPlayerController.file(File(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _player?.play();
        });
      });
    _player?.setLooping(true);
  }

  _pausePlayer() {
    _player?.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            VideoTemplatePreviewHeader(
              share: _shareVideo,
              pausePlayer: _pausePlayer,
            ),
            _player != null
                ? GestureDetector(
                    onTap: () {
                      _player?.play();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: AspectRatio(
                            aspectRatio: _player!.value.aspectRatio,
                            child: VideoPlayer(_player!),
                          ),
                        ),
                      ),
                    ),
                  )
                : CircularProgressIndicator(),
            AppTextStyles.blankHeight(height: 16),
          ],
        ),
      ),
    );
  }
}
