import 'package:flutter/cupertino.dart';

///扩展int以方便使用
extension IntFix on int {
  ///eg：200.px
  double get px {
    return ScreenHelper.getPx(toDouble());
  }
}

///扩展double以方便使用
extension DoubleFix on double {
  ///eg：200.0.px
  double get px {
    return ScreenHelper.getPx(this);
  }
}

///屏幕适配工具类，如果UI要求要和UI稿完全一致的还原度时可以使用
class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double radio;

  ///根据设计稿实际宽度初始化
  ///baseWidth 设计稿宽度
  static init(BuildContext context, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    radio = screenWidth / baseWidth;
  }

  ///获取设计稿对应的大小
  static double getPx(double size) {
    return ScreenHelper.radio * size;
  }
}
