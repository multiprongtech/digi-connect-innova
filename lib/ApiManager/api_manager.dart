import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  //: ApiCall
  Future<T> request<T>(
      String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      int type,
      T Function(dynamic json) fromJson) async {
    print(url);
    print(body);
    final response = (type == 1)
        ? await http.get(Uri.parse(url), headers: headers)
        : await http.post(Uri.parse(url), headers: headers, body: body);

    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = fromJson(jsonResponse);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
