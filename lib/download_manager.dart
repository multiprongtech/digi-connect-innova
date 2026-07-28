import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as pathProvider;

class DownloadManager {
  static Future<String?> downloadVideo(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      final dir = await getDownloadDirectory();
      if (dir == null) {
        return null;
      } else {
        final file = File('${dir!.path}/$filename');
        await file.writeAsBytes(bytes);
        return file.path;
      }
    } catch (e) {
      print('Error downloading video: $e');
      return null;
    }
  }

//get download directory
  static Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      final storage = await pathProvider.getExternalStorageDirectory();
      return storage;
    } else {
      return await pathProvider.getApplicationDocumentsDirectory();
    }
  }
}
