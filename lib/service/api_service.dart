import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/globals.dart';
import '../data/secrets.dart';
import '../model/app_data_model.dart';

class ApiService {
  static Future<String> fetchApi(String apiKey, String content) async {
    try {
      String url = 'https://chimeragpt.adventblocks.cc/v1/chat/completions';
      // String url = 'https://api.hypere.app/v1/chat/completions';

      final Map<String, String> headers = {
        'authorization': 'Bearer $apiKey'
            '',
        'Content-Type': 'application/json'
      };
      final Map<String, dynamic> data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            "role": "system",
            "content": formatter,
          },
          {
            'role': 'user',
            'content': content,
          }
        ],
        'max_tokens': 2048
      };

      final res = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      // print(res.body);

      Map<String, dynamic> result = jsonDecode(res.body);

      String resData = '';

      // result['choices'].forEach((value) {
      //   String content = value['message']['content'];
      //   resData = content;
      // });

      final choice = result['choices'];

      final message = (choice[0]['message'])['content'];

      resData = message;
      if (kDebugMode) {
        print('responceAPI: $resData');
      }
      return resData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> serverStatus() async {
    try {
      String url = 'https://chimeragpt.adventblocks.cc/';

      final res = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(res.statusCode);
      }
      if (kDebugMode) {
        print('Chimera, $apiKey');
      }
      return res.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error : $e');
      }
      return false;
    }
  }

  static Future<List<AppData>> getCard(
      {int? limit, String? query, int? page}) async {
    String url =
        'https://studentai-api.vercel.app/search?apps=${query ?? ""}&limit=${limit ?? 0}&page=${page ?? 0}';
    final res = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(res.body);
    List<dynamic> dataList = data['result'];
    List<AppData> appData = dataList.map((e) => AppData.fromJson(e)).toList();
    return appData;
  }

  static Future<Map<String, dynamic>> getId(String id) async {
    String url = 'http://studentai-api.vercel.app/id/$id';
    final res = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(res.body);
    return data;
  }
}
