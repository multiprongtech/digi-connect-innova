import 'dart:convert';
import 'dart:io';
import 'package:digi_connect/AppConstant/app_constant.dart';
import 'package:digi_connect/VideosPage/View/video_image_overlay.dart';
import 'package:digi_connect/download_manager.dart';
/*import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';*/
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoMergeController extends GetxController {
  var templateVideoPath = ''.obs;
  var videoPath = ''.obs;
  var imgPath = ''.obs;
  var updatedVideoPath = ''.obs;

//: download template video
  downloadVideoFrom(String url, VideoPlayerController plyrCtrl) async {
    final path = await DownloadManager.downloadVideo(url, 'video_template.mp4');
    VideoPlayerController _controller;
    if (path != null) {
      templateVideoPath.value = path;

      _controller = VideoPlayerController.file(File(path));
      _controller.initialize().then((value) async {
        Duration duration = _controller.value.duration;
        _mergeVideo(duration, plyrCtrl);
      });
    } else {
      //print('Error downloading video');
      AppConstant.showSnackBar(
          'Error!!', 'Downloadable video path incorrect. $path');
      Get.back();
    }
  }

  //: overlay image to video
  void _mergeVideo(Duration duration, VideoPlayerController plyrCtrl) async {
    //: output URL
    final directory = (Platform.isAndroid)
        ? await getApplicationDocumentsDirectory()
        : await getApplicationDocumentsDirectory();

    print("Directoryy>>>>>>>>>>>> $directory");
    final outputPath =
        directory.path + ((Platform.isAndroid) ? 'output.mp4' : '/output.mp4');

    print("OUTPUT_PATH>>>>>>>>>>>> $outputPath");

    //: template downloaded url
    String vFilePath = videoPath.value;
    final video1 = vFilePath;

    final vfilePathInfo = await FFprobeKit.getMediaInformation(outputPath);

    final outputV = await vfilePathInfo.getOutput();
    print("OUTPUT:  $outputV");

    //: image path set
    final video2 = imgPath.value;

    final templateAudioInfo =
    await FFprobeKit.getMediaInformation(templateVideoPath.value);

//final session = FFmpegKit.execute('-i ${templateVideoPath.value}');
    final output = await templateAudioInfo.getOutput();
    print(output);
    Map<String, dynamic> jsonOutput = jsonDecode(output!);
    List<dynamic> streams = jsonOutput['streams'];
    String frameRate = '24';
    for (var stream in streams) {
      frameRate = stream['r_frame_rate'];
      print(frameRate);
      break;
    }

    print('Frame rate: $frameRate');

    //: command creating image to video
    print(plyrCtrl.value.aspectRatio);
    final strCommand =
    //    '-y -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -loop 1 -i $video2 -pix_fmt yuv420p -r $frameRate -t 3 -vf scale=16:9 $outputPath';
        '-y -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -loop 1 -i $video2 -pix_fmt yuv420p -r $frameRate -t 5 -vf scale=${plyrCtrl.value.size.width}:${plyrCtrl.value.size.height} $outputPath';

    //: '-y -loop 1 -i $video2 -pix_fmt yuv420p -t 3 -vf scale=${plyrCtrl.value.size.width}:${plyrCtrl.value.size.height} -vsync vfr $outputPath';

    //: execution process for over lay
    FFmpegKit.executeAsync(strCommand, (session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        // SUCCESS Final merge command
        _concat(outputPath);
      } else if (ReturnCode.isCancel(returnCode)) {
        // CANCEL
        AppConstant.showSnackBar(
            'Failed!!', 'Procesing video cancelled. Try again later.');
        Get.back();
      } else {
        // ERROR
        AppConstant.showSnackBar(
            'Error!!', 'Something went wrong. Please try again later.');
        Get.back();
      }
    }, (logCallback) {
      // Handle error callback
      print(logCallback.getMessage());
    });
  }

//concat video
  _concat(String outputPath) async {
    print("CONCAT START>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

    final directory = (Platform.isAndroid)
        ? await getApplicationDocumentsDirectory()
        : await getApplicationDocumentsDirectory();
    final concatOutput =
        directory.path + ((Platform.isAndroid) ? 'concat.mp4' : '/concat.mp4');
    print(
        "PATHS: $outputPath >>>>>>>>> ${templateVideoPath.value} >>>>>>>>> $concatOutput");
    //concat command
    final String concatCommand =
        '-y -i $outputPath -i ${templateVideoPath.value} -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" $concatOutput';

    //'-y -i ${templateVideoPath.value} -i $outputPath -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" $concatOutput';

    //'-y -i video.mp4 -i promo-image.mp4 -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" video-with-promo.mp4'
    //: '-y -i  ${templateVideoPath.value} -i $outputPath -filter_complex "[0:v:0][1:v:0]concat=n=2:v=1[outv]" -map "[outv]" $concatOutput';

    //'-y -i  ${templateVideoPath.value} -i $outputPath -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" $concatOutput';

    FFmpegKit.executeAsync(concatCommand, (session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        // SUCCESS
        updatedVideoPath.value = concatOutput;
        Get.back(result: updatedVideoPath.value);
      } else if (ReturnCode.isCancel(returnCode)) {
        Get.back();
        // CANCEL
        AppConstant.showSnackBar(
            'Failed!!', 'Cancelled video processing. Try again later.');
      } else {
        Get.back();
        // ERROR
        AppConstant.showSnackBar(
            'Error!!', 'Something went wrong. Try again later.');
      }
    }, (logCallback) {
      // Handle error callback
      print(logCallback.getMessage());
    });
  }
}
