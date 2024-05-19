import 'package:flutter/material.dart';
import 'package:trip_flutter/mvvm/login/views/login_page.dart';
import 'package:trip_flutter/mvvm/main/views/bottom_tab_view.dart';

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
}