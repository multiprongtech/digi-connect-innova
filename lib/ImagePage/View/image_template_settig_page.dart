import 'dart:io';
import 'package:digi_connect/AppThemes/AppTextStyle.dart';
import 'package:digi_connect/ImagePage/Controller/ImagePageController.dart';
import 'package:digi_connect/OnboardPage/onboard_controller.dart';
import 'package:digi_connect/VideosPage/View/video_image_overlay.dart';
import 'package:digi_connect/VideosPage/View/video_template_final_preview.dart';
import 'package:digi_connect/VideosPage/View/video_template_processing_page.dart';
import 'package:digi_connect/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'image_template_Preview_header.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;


class ImageTemplateSettingPage extends StatefulWidget {
  ImageTemplateSettingPage({
    super.key,
    required this.templateUrl,
    required this.cat_id,
    required this.tempid,
    required this.imagePath1,
    required this.inputTextTo,
    required this.inputTextFrom,
    required this.inputTextDesignation,
    required this.inputTextLocation,
  });
  String templateUrl;
  String tempid;
  int cat_id;
  String inputTextTo;
  String inputTextFrom;
  String inputTextDesignation;
  String inputTextLocation;
  String imagePath1;

  @override
  State<ImageTemplateSettingPage> createState() =>
      _ImageTemplateSettingPageState();
}

class _ImageTemplateSettingPageState extends State<ImageTemplateSettingPage> {
  Offset position = Offset(100, 100);
  Offset txtposition = Offset(110, 80);
  Offset extraTextPosition = Offset(110, 80);
  Offset text1Position = Offset(50, 50);
  Offset text2Position = Offset(50, 100);
  Offset text3Position = Offset(50, 150);
  final _key = GlobalKey();

//: update position
  _updatePositionForCategoryId3() async {
    position = (widget.cat_id == 3)
        ? Offset(30, Get.height * 0.3)
        : (widget.cat_id == 6)
        ? Offset(30, Get.height * 0.2)
        : (widget.cat_id == 1)
        ? Offset(110, 40)
        : Offset(Get.width * 0.3, Get.height * 0.3);

    extraTextPosition =
    (widget.cat_id == 3) ? Offset(130, Get.height * 0.3) : Offset(0, 0);

    txtposition = (widget.cat_id == 3)
        ? Offset(110, 80)
        : (widget.cat_id == 2)
        ? Offset(90, Get.height * 0.2)
        : (widget.cat_id == 1)
        ? Offset(90, 150)
        : Offset(90, Get.height * 0.57);

    setState(() {});
  }

//Update activity api
  _updateActivity() async {
    var user = await OnBoardController().retrievePerson();
    var param = {
      'employee_id': '${user!.userId}',
      'category_id': '${widget.cat_id}',
      'product_id': widget.tempid,
      'To': widget.inputTextTo,
      'From': widget.inputTextFrom,
      'Designation': widget.inputTextDesignation,
    };
    await ImagePageController().saveShareDataToServer(param);
  }

  @override
  void initState() {
    super.initState();
    _updatePositionForCategoryId3();
  }

  //: capture png
  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
    _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    if (widget.cat_id == 1) {
      final pathDirectory = await getTemporaryDirectory();
      final path = pathDirectory.path + '/video_bg.png';
      await File(path).writeAsBytes(pngBytes);
      print(path);
      print(pathDirectory.path);
      _mergeVideo(path);
    } else {
      var isShared = await Share.shareXFiles([
        XFile.fromData(pngBytes, mimeType: 'image/png'),
      ]);

      if (isShared.status == ShareResultStatus.success) {
        print("success");
        _updateActivity();
      } else {
        print("not success");
      }
    }
  }

  //: merge video
  _mergeVideo(String img_path) {
    if (selectedVideoTemplate == null ||
        selectedVideoPlayerController == null) {
    } else {
      //: show processing page

      Get.bottomSheet(
        VideoTemplateProcessingPage(
          videoUrl: selectedVideoTemplate!,
          image: XFile(img_path),
          plyrCtrl: selectedVideoPlayerController!,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ).then((value) {
        Get.to(
          VideoTemplatePreviewPage(videoUrl: value as String),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ImageTemplatePreviewHeader(
              share: _capturePng,
              btnTitle: widget.cat_id == 1 ? 'Merge Video' : 'Share',
            ),
            Container(
              child: RepaintBoundary(
                key: _key,
                child: Stack(
                  children: [
                    IgnorePointer(
                      ignoring: true,
                      child: Image.network(
                        widget.templateUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    (widget.cat_id == 6)
                        ? Stack(
                      children: [
                        (widget.cat_id == 2)
                            ? AppTextStyles.blankWidth()
                            : Positioned(
                          left: position.dx,
                          top: position.dy,
                          child: Container(
                            width: (widget.cat_id == 3)
                                ? 60
                                : (widget.cat_id == 6)
                                ? Get.width * 0.8
                                : 170,
                            height: (widget.cat_id == 3)
                                ? 60
                                : (widget.cat_id == 6)
                                ? Get.width * 0.8
                                : 170,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  position = Offset(
                                      position.dx + details.delta.dx,
                                      position.dy + details.delta.dy);
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    (widget.cat_id == 3)
                                        ? 10
                                        : (widget.cat_id == 6)
                                        ? (Get.width * 0.8) / 2
                                        : 0,
                                  ),
                                ),
                                child: Image.file(
                                  File(
                                    widget.imagePath1,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: Image.network(
                            widget.templateUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        (widget.cat_id == 3)
                            ? Positioned(
                          left: extraTextPosition.dx,
                          top: extraTextPosition.dy,
                          child: Container(
                            width: Get.width * 0.5,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  extraTextPosition = Offset(
                                      extraTextPosition.dx +
                                          details.delta.dx,
                                      extraTextPosition.dy +
                                          details.delta.dy);
                                });
                              },
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputTextFrom,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.inputTextDesignation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.inputTextLocation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            : Text(''),
                        Positioned(
                          left: txtposition.dx,
                          top: txtposition.dy,
                          child: Container(
                            child: GestureDetector(
                              onPanStart: (details) {
                                print("Start updating");
                              },
                              onPanEnd: (detail) {
                                print('End');
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  txtposition = Offset(
                                      txtposition.dx + details.delta.dx,
                                      txtposition.dy + details.delta.dy);
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width * 0.7,
                                    child: Text(
                                      widget.inputTextTo,
                                      maxLines: 2,
                                      textAlign: (widget.cat_id == 3)
                                          ? TextAlign.left
                                          : TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: (widget.cat_id == 3)
                                          ? AppTextStyles.heading2(context)
                                          : (widget.inputTextTo.length > 20)
                                          ? AppTextStyles.heading1(
                                          context)
                                          : AppTextStyles.headLine(
                                          context),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Stack(
                      children: [
                        IgnorePointer(
                          ignoring: true,
                          child: Image.network(
                            widget.templateUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        (widget.cat_id == 2 || widget.cat_id == 4 ||
                                (widget.cat_id == 3 && widget.imagePath1.isEmpty))
                            ? AppTextStyles.blankWidth()
                            : Positioned(
                          left: position.dx,
                          top: position.dy,
                          child: Container(
                            width: (widget.cat_id == 3)
                                ? 60
                                : (widget.cat_id == 6)
                                ? Get.width * 0.75
                                : (widget.cat_id == 1)
                                ? 100
                                : 170,
                            height: (widget.cat_id == 3)
                                ? 60
                                : (widget.cat_id == 6)
                                ? Get.width * 0.7
                                : (widget.cat_id == 1)
                                ? 100
                                : 170,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  position = Offset(
                                      position.dx + details.delta.dx,
                                      position.dy + details.delta.dy);
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    (widget.cat_id == 3)
                                        ? 10
                                        : (widget.cat_id == 6)
                                        ? (Get.width * 0.7) / 2
                                        : 0,
                                  ),
                                ),
                                child: Image.file(
                                  File(
                                    widget.imagePath1,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        (widget.cat_id == 3)
                            ? Positioned(
                          left: extraTextPosition.dx,
                          top: extraTextPosition.dy,
                          child: Container(
                            width: Get.width * 0.5,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  extraTextPosition = Offset(
                                      extraTextPosition.dx +
                                          details.delta.dx,
                                      extraTextPosition.dy +
                                          details.delta.dy);
                                });
                              },
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.inputTextFrom,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.inputTextDesignation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    widget.inputTextLocation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            : Text(''),
                        Positioned(
                          left: txtposition.dx,
                          top: txtposition.dy,
                          child: Container(
                            child: GestureDetector(
                              onPanStart: (details) {
                                print("Start updating");
                              },
                              onPanEnd: (detail) {
                                print('End');
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  txtposition = Offset(
                                      txtposition.dx + details.delta.dx,
                                      txtposition.dy + details.delta.dy);
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width * 0.7,
                                    child: Text(
                                      widget.inputTextTo,
                                      maxLines: 2,
                                      textAlign: (widget.cat_id == 3)
                                          ? TextAlign.left
                                          : TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: (widget.cat_id == 3)
                                          ? AppTextStyles.heading2(context)
                                          : (widget.cat_id == 2)
                                          ? (widget.inputTextTo.length >
                                          12)
                                          ? AppTextStyles.heading1(
                                          context)
                                          : AppTextStyles.headLineNew(
                                          context)
                                          : (widget.cat_id == 1)
                                          ? AppTextStyles
                                          .boldSubTitle(context)
                                          : AppTextStyles.heading2(
                                          context),
                                    ),
                                  ),
                                  Container(
                                    width: Get.width * 0.7,
                                    child: Text(
                                      (widget.cat_id == 27 ||
                                          widget.cat_id == 2)
                                          ? widget.inputTextDesignation
                                          : '',
                                      maxLines: 2,
                                      textAlign: (widget.cat_id == 3)
                                          ? TextAlign.left
                                          : TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.boldTitle(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.cat_id == 30) ...[
                      Positioned(
                        left: text1Position.dx,
                        top: text1Position.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              text1Position = Offset(
                                  text1Position.dx + details.delta.dx,
                                  text1Position.dy + details.delta.dy);
                            });
                          },
                          child: Text(
                            widget.inputTextFrom,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: text2Position.dx,
                        top: text2Position.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              text2Position = Offset(
                                  text2Position.dx + details.delta.dx,
                                  text2Position.dy + details.delta.dy);
                            });
                          },
                          child: Text(
                            widget.inputTextDesignation,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: text3Position.dx,
                        top: text3Position.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              text3Position = Offset(
                                  text3Position.dx + details.delta.dx,
                                  text3Position.dy + details.delta.dy);
                            });
                          },
                          child: Text(
                            widget.inputTextLocation,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: txtposition.dx,
                        top: txtposition.dy,
                        child: Container(
                          child: GestureDetector(
                            onPanStart: (details) {
                              print("Start updating");
                            },
                            onPanEnd: (detail) {
                              print('End');
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                txtposition = Offset(
                                    txtposition.dx + details.delta.dx,
                                    txtposition.dy + details.delta.dy);
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    widget.inputTextTo,
                                    maxLines: 2,
                                    textAlign: (widget.cat_id == 3)
                                        ? TextAlign.left
                                        : TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: (widget.cat_id == 3)
                                        ? AppTextStyles.heading2(context)
                                        : (widget.inputTextTo.length > 20)
                                        ? AppTextStyles.heading1(context)
                                        : AppTextStyles.headLine(context),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*class ImageTemplateSettingPage extends StatefulWidget {
  ImageTemplateSettingPage({
    super.key,
    required this.templateUrl,
    required this.cat_id,
    required this.tempid,
    required this.imagePath1,
    required this.inputTextTo,
    required this.inputTextFrom,
    required this.inputTextDesignation,
    required this.inputTextLocation,
  });
  String templateUrl;
  String tempid;
  int cat_id;
  String inputTextTo;
  String inputTextFrom;
  String inputTextDesignation;
  String inputTextLocation;
  String imagePath1;

  @override
  State<ImageTemplateSettingPage> createState() =>
      _ImageTemplateSettingPageState();
}

class _ImageTemplateSettingPageState extends State<ImageTemplateSettingPage> {
  Offset position = Offset(100, 100);
  Offset txtposition = Offset(110, 80);
  Offset extraTextPosition = Offset(110, 80);
  final _key = GlobalKey();

//: update position
  _updatePositionForCategoryId3() async {
    position = (widget.cat_id == 3)
        ? Offset(30, Get.height * 0.3)
        : (widget.cat_id == 6)
            ? Offset(30, Get.height * 0.2)
            : (widget.cat_id == 1)
                ? Offset(110, 40)
                : Offset(Get.width * 0.3, Get.height * 0.3);

    extraTextPosition =
        (widget.cat_id == 3) ? Offset(130, Get.height * 0.3) : Offset(0, 0);

    txtposition = (widget.cat_id == 3)
        ? Offset(110, 80)
        : (widget.cat_id == 2)
            ? Offset(90, Get.height * 0.2)
            : (widget.cat_id == 1)
                ? Offset(90, 150)
                : Offset(90, Get.height * 0.57);

    setState(() {});
  }

//Update activity api
  _updateActivity() async {
    var user = await OnBoardController().retrievePerson();
    var param = {
      'employee_id': '${user!.userId}',
      'category_id': '${widget.cat_id}',
      'product_id': widget.tempid,
      'To': widget.inputTextTo,
      'From': widget.inputTextFrom,
      'Designation': widget.inputTextDesignation,
    };
    await ImagePageController().saveShareDataToServer(param);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updatePositionForCategoryId3();
  }

  //: capture png
  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    if (widget.cat_id == 1) {
      final pathDirectory = await getTemporaryDirectory();
      final path = pathDirectory.path + '/video_bg.png';
      await File(path).writeAsBytes(pngBytes);
      print(path);
      print(pathDirectory.path);
      _mergeVideo(path);
    } else {
      var isShared = await Share.shareXFiles([
        XFile.fromData(pngBytes, mimeType: 'image/png'),
      ]);

      if (isShared.status == ShareResultStatus.success) {
        print("success");
        _updateActivity();
      } else {
        print("not success");
      }
    }
  }

//: merge video
  _mergeVideo(String img_path) {
    if (selectedVideoTemplate == null ||
        selectedVideoPlayerController == null) {
    } else {
      //: show processing page

      Get.bottomSheet(
        VideoTemplateProcessingPage(
          videoUrl: selectedVideoTemplate!,
          image: XFile(img_path),
          plyrCtrl: selectedVideoPlayerController!,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ).then((value) {
        Get.to(
          VideoTemplatePreviewPage(videoUrl: value as String),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ImageTemplatePreviewHeader(
              share: _capturePng,
              btnTitle: widget.cat_id == 1 ? 'Merge Video' : 'Share',
            ),
            Container(
              child: RepaintBoundary(
                key: _key,
                child: (widget.cat_id == 6)
                    ? Stack(
                        children: [
                          (widget.cat_id == 2)
                              ? AppTextStyles.blankWidth()
                              : Positioned(
                                  left: position.dx,
                                  top: position.dy,
                                  child: Container(
                                    width: (widget.cat_id == 3)
                                        ? 60
                                        : (widget.cat_id == 6)
                                            ? Get.width * 0.8
                                            : 170,
                                    height: (widget.cat_id == 3)
                                        ? 60
                                        : (widget.cat_id == 6)
                                            ? Get.width * 0.8
                                            : 170,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          position = Offset(
                                              position.dx + details.delta.dx,
                                              position.dy + details.delta.dy);
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            (widget.cat_id == 3)
                                                ? 10
                                                : (widget.cat_id == 6)
                                                    ? (Get.width * 0.8) / 2
                                                    : 0,
                                          ),
                                        ),
                                        child: Image.file(
                                          File(
                                            widget.imagePath1,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          IgnorePointer(
                            ignoring: true,
                            child: Image.network(
                              widget.templateUrl,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          (widget.cat_id == 3)
                              ? Positioned(
                                  left: extraTextPosition.dx,
                                  top: extraTextPosition.dy,
                                  child: Container(
                                    width: Get.width * 0.5,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          extraTextPosition = Offset(
                                              extraTextPosition.dx +
                                                  details.delta.dx,
                                              extraTextPosition.dy +
                                                  details.delta.dy);
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.inputTextFrom,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            widget.inputTextDesignation,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            widget.inputTextLocation,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Text(''),
                          Positioned(
                            left: txtposition.dx,
                            top: txtposition.dy,
                            child: Container(
                              child: GestureDetector(
                                onPanStart: (details) {
                                  print("Start updating");
                                },
                                onPanEnd: (detail) {
                                  print('End');
                                },
                                onPanUpdate: (details) {
                                  setState(() {
                                    txtposition = Offset(
                                        txtposition.dx + details.delta.dx,
                                        txtposition.dy + details.delta.dy);
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.7,
                                      child: Text(
                                        widget.inputTextTo,
                                        maxLines: 2,
                                        textAlign: (widget.cat_id == 3)
                                            ? TextAlign.left
                                            : TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: (widget.cat_id == 3)
                                            ? AppTextStyles.heading2(context)
                                            : (widget.inputTextTo.length > 20)
                                                ? AppTextStyles.heading1(
                                                    context)
                                                : AppTextStyles.headLine(
                                                    context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          IgnorePointer(
                            ignoring: true,
                            child: Image.network(
                              widget.templateUrl,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          (widget.cat_id == 2 || widget.cat_id == 4)
                              ? AppTextStyles.blankWidth()
                              : Positioned(
                                  left: position.dx,
                                  top: position.dy,
                                  child: Container(
                                    width: (widget.cat_id == 3)
                                        ? 60
                                        : (widget.cat_id == 6)
                                            ? Get.width * 0.75
                                            : (widget.cat_id == 1)
                                                ? 100
                                                : 170,
                                    height: (widget.cat_id == 3)
                                        ? 60
                                        : (widget.cat_id == 6)
                                            ? Get.width * 0.7
                                            : (widget.cat_id == 1)
                                                ? 100
                                                : 170,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          position = Offset(
                                              position.dx + details.delta.dx,
                                              position.dy + details.delta.dy);
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            (widget.cat_id == 3)
                                                ? 10
                                                : (widget.cat_id == 6)
                                                    ? (Get.width * 0.7) / 2
                                                    : 0,
                                          ),
                                        ),
                                        child: Image.file(
                                          File(
                                            widget.imagePath1,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          (widget.cat_id == 3)
                              ? Positioned(
                                  left: extraTextPosition.dx,
                                  top: extraTextPosition.dy,
                                  child: Container(
                                    width: Get.width * 0.5,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          extraTextPosition = Offset(
                                              extraTextPosition.dx +
                                                  details.delta.dx,
                                              extraTextPosition.dy +
                                                  details.delta.dy);
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.inputTextFrom,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            widget.inputTextDesignation,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            widget.inputTextLocation,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Text(''),
                          Positioned(
                            left: txtposition.dx,
                            top: txtposition.dy,
                            child: Container(
                              child: GestureDetector(
                                onPanStart: (details) {
                                  print("Start updating");
                                },
                                onPanEnd: (detail) {
                                  print('End');
                                },
                                onPanUpdate: (details) {
                                  setState(() {
                                    txtposition = Offset(
                                        txtposition.dx + details.delta.dx,
                                        txtposition.dy + details.delta.dy);
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.7,
                                      child: Text(
                                        widget.inputTextTo,
                                        maxLines: 2,
                                        textAlign: (widget.cat_id == 3)
                                            ? TextAlign.left
                                            : TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: (widget.cat_id == 3)
                                            ? AppTextStyles.heading2(context)
                                            : (widget.cat_id == 2)
                                                ? (widget.inputTextTo.length >
                                                        12)
                                                    ? AppTextStyles.heading1(
                                                        context)
                                                    : AppTextStyles.headLineNew(
                                                        context)
                                                : (widget.cat_id == 1)
                                                    ? AppTextStyles
                                                        .boldSubTitle(context)
                                                    : AppTextStyles.heading2(
                                                        context),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.7,
                                      child: Text(
                                        (widget.cat_id == 27 ||
                                                widget.cat_id == 2)
                                            ? widget.inputTextDesignation
                                            : '',
                                        maxLines: 2,
                                        textAlign: (widget.cat_id == 3)
                                            ? TextAlign.left
                                            : TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.boldTitle(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
