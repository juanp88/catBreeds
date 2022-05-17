import 'dart:convert';
import 'dart:io';

import 'package:cat_breed/model/cat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/api_status.dart';
import '../utils/config.dart';

class CatService {
  static Future<Object> getCats() async {
    List<Cat> catsFromJson(String str) =>
        List<Cat>.from(json.decode(str).map((x) => Cat.fromJson(x)));

    try {
      final response = await http.get(
          Uri.parse('${Config.baseURL}${Config.endpoint}'),
          headers: Config.headers);

      if (response.statusCode == 200) {
        var res = utf8.decode(response.bodyBytes);
        return Success(response: catsFromJson(res));
      }
      return Failure(code: 100, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No Internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknown Error');
    }
  }
}
