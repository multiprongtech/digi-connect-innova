import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/HomePage/Controller/home_page_controller.dart';
import 'package:digi_connect/HomePage/Model/home_page_model.dart';
import 'package:digi_connect/ImagePage/Model/ImageTemplateModel.dart';
import 'package:digi_connect/VideosPage/Controller/video_controller.dart';
import 'package:digi_connect/VideosPage/Model/video_template_model.dart';
import 'package:digi_connect/VideosPage/View/video_image_overlay.dart';
import 'package:digi_connect/VideosPage/View/video_page_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPages extends StatefulWidget {
  VideoPages({super.key, required this.category});
  Categories category;

  @override
  State<VideoPages> createState() => _VideoPagesState();
}

class _VideoPagesState extends State<VideoPages> {
  final controller = VideoPageController();
  var templates = <ImageTemplateData>[].obs;
  var apiMessage = "Fetching data...".obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVideoTemplates();
  }

//Get video template
  _getVideoTemplates() async {
    final response = await controller.getTemplateData(widget.category.id ?? 1);
    templates.value = response.data ?? [];
    if (templates.value.length < 1) {
      apiMessage.value = response.message ?? "No data found.";
    } else {
      apiMessage.value = "";
    }
  }

  /* final videoTemplateLinks = [
    VideoTemplateModel(
        videoLink:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        thumbLink: 'https://loremflickr.com/640/360'),
    VideoTemplateModel(
        videoLink:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
        thumbLink: 'https://loremflickr.com/600/320'),
    VideoTemplateModel(
        videoLink:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        thumbLink: 'https://loremflickr.com/630/350'),
    VideoTemplateModel(
        videoLink:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
        thumbLink: 'https://loremflickr.com/620/340'),
    VideoTemplateModel(
        videoLink:
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
        thumbLink: 'https://loremflickr.com/610/320'),
  ];
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const VideoPageHeader(),
            AppTextStyles.blankHeight(height: 12),
            Obx(() {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: templates.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.to(
                          VideoImageOverlayPage(
                            videoUrl: templates[index].imageUrl ?? '',
                            category: widget.category,
                            tempid: '${templates.value[index].id}',
                          ),
                        );
                      },
                      child: VideoCard(
                        videoModel: templates.value[index],
                      ),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.55,
                    ),
                  ),
                ),
              );
            }),
            AppTextStyles.blankHeight(),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  VideoCard({super.key, required this.videoModel});

  ImageTemplateData videoModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage(
              AppConstant.iconVideo,
            ),
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
