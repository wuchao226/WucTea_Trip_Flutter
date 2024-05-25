import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/model/search_model.dart';
import 'package:trip_flutter/util/logger_util.dart';
import 'package:trip_flutter/util/navigator_util.dart';

///搜索接口
class SearchDao {
  static Future<SearchModel?> fetch(String text) async {
    var uri = Uri.parse("https://api.geekailab.com/uapi/ft/search?q=$text");
    final response = await http.get(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      LoggerUtil.i(result);
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      LoggerUtil.i(bodyString);
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(bodyString);
    }
  }
}
