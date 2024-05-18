import 'package:flutter/material.dart';

///登录输入框，自定义widget
class InputWidget extends StatelessWidget {
  ///输入框提示文案
  final String hint;

  ///输入框内容变化回调
  final ValueChanged<String>? onChange;

  /// 是否以密码的方式显示
  final bool obscureText;

  /// 键盘类型
  final TextInputType? keyboardType;
  const InputWidget(this.hint, {super.key, this.onChange, this.obscureText = false, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        const Divider(
          color: Colors.white,
          height: 1,
          thickness: 0.5,
        ),
      ],
    );
  }

  _input() {
    return TextField(
      onChanged: onChange,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofocus: !obscureText,
      cursorColor: Colors.white,
      style: const TextStyle(
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      //输入框的样式
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
      ),
    );
  }
}
