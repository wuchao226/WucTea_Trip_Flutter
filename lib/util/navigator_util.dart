import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_flutter/mvvm/login/views/login_page.dart';
import 'package:trip_flutter/mvvm/main/views/bottom_tab_view.dart';
import 'package:trip_flutter/util/logger_util.dart';

import '../widget/hi_webview.dart';

class NavigatorUtil {
  ///用于在获取不到context的地方，如dao中跳转页面时使用，需要在TabNavigator赋值
  ///注意：若TabNavigator被销毁，_context将无法使用
  static BuildContext? _context = null;

  static void updateContext(BuildContext? context) {
    NavigatorUtil._context = context;
    print('init:$context');
  }

  ///跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  ///返回上一页
  static pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      //退出APP
      SystemNavigator.pop();
    }
  }

  ///跳转到首页
  static goToHome(BuildContext context) {
    // 跳转到主页并不让返回
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomTabView()));
  }

  ///跳转到登录页
  static goToLogin() {
    // 跳转到登录页并不让返回
    Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  ///跳转H5页面
  static void jumpH5({BuildContext? context, String? url, String? title, bool? hideAppBar, String? statusBarColor}) {
    BuildContext? safeContext;
    if (url == null) {
      LoggerUtil.e('url is null jumpH5 failed.');
      return;
    }
    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context;
    } else {
      LoggerUtil.e('context is null jumpH5 failed.');
      return;
    }
    Navigator.push(
      safeContext!,
      MaterialPageRoute(
        builder: (context) => HiWebView(
          url: url,
          title: title,
          hideAppBar: hideAppBar,
          statusBarColor: statusBarColor,
        ),
      ),
    );
  }
}
