import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/secrets.dart';
import '../model/app_data_model.dart';

class ApiService {
  static Future<String> fetchApi(String apiKey, String content) async {
    try {
      final url =
          'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$apiKey';

      final Map<String, dynamic> data = {
        'prompt': {
          'text': content,
        }
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      Map<String, dynamic> result = jsonDecode(response.body);

      String resData = result['candidates'][0]['output'];
      if (kDebugMode) {
        print('responseAPI: $resData');
      }
      return resData;
    } catch (e) {
      // throw Exception(e.toString());
      if (kDebugMode) {
        print('API Error: $e');
      }
      return "Something went wrong!! Please, try again later.";
    }
  }

  static Future<bool> serverStatus() async {
    try {
      String url = 'https://api.pawan.krd/pai-001-light-beta/v1';

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
