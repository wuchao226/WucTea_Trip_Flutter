import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/logger_util.dart';
import 'package:trip_flutter/util/navigator_util.dart';

///首页大接口
class HomeDao {
  static Future<HomeModel?> fetch() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/home');
    final response = await http.get(url, headers: hiHeaders());
    //fix 中文乱码
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      LoggerUtil.i(result);
      return HomeModel.fromJson(result['data']);
    } else {
      LoggerUtil.e(bodyString);
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(bodyString);
    }
  }
}
