import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/AppThemes/AppTheme.dart';
import 'package:digi_connect/FormPage/view/form_page.dart';
import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:digi_connect/VideosPage/Controller/video_image_overlay_controller.dart';
import 'package:digi_connect/VideosPage/Model/BGImage_model.dart';
import 'package:digi_connect/VideosPage/View/video_image_overlay_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

String? selectedVideoTemplate;
VideoPlayerController? selectedVideoPlayerController;

class VideoImageOverlayPage extends StatefulWidget {
  VideoImageOverlayPage(
      {super.key,
      required this.videoUrl,
      required this.tempid,
      required this.category});
  String videoUrl;
  String tempid;
  Categories category;

  @override
  State<VideoImageOverlayPage> createState() => _VideoImageOverlayPageState();
}

class _VideoImageOverlayPageState extends State<VideoImageOverlayPage> {
  late VideoPlayerController _player;
  final controller = VideoImageOverlayController();
  var templates = <BGImageData>[].obs;

  //Get bg images for video
  _getVideoBgImages() async {
    final response = await controller.getTemplateData();
    if (response.status == 200) {
      templates.value = response.data ?? [];
    }
  }

//: initialize
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedVideoTemplate = widget.videoUrl;
    _getVideoBgImages();
    controller.videoUrl = widget.videoUrl;

    _player = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _player.play();
        });
      });
    selectedVideoPlayerController = _player;
    _player.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            VideoImageOverlayHeader(),
            AppTextStyles.blankHeight(height: 12),
            _player.value.isInitialized
                ? Padding(
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
                          aspectRatio: _player.value.aspectRatio,
                          child: VideoPlayer(_player),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppConstant.appThemeColor,
                    ),
                  ),
            Spacer(),
            Row(
              children: [
                AppTextStyles.blankWidth(width: 16),
                Text(
                  'Select Image',
                  style: AppTextStyles.heading2(context),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
              ],
            ),
            Obx(() {
              return SizedBox(
                width: Get.width * 0.9,
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < templates.value.length; i++)
                      GestureDetector(
                        onTap: () {
                          _player.pause();
                          Get.to(
                            FormPage(
                              templateUrl: templates.value[i].imageUrl ?? '',
                              cat_id: widget.category.id ?? 1,
                              heading: widget.category.title ?? 'Video',
                              tempid: '${templates.value[i].id}',
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                templates.value[i].imageUrl ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
            AppTextStyles.blankHeight(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player.pause();
  }
}
