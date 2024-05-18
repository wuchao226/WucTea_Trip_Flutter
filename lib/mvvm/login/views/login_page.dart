import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/string_util.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/input_widget.dart';
import 'package:trip_flutter/widget/login_widget.dart';
import 'package:url_launcher/url_launcher.dart';

///登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 防止键盘弹起影响布局
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ..._background(),
          ..._content(),
        ],
      ),
    );
  }

  _background() {
    return [
      Positioned.fill(
        child: Image.asset(
          "images/login-bg1.jpg",
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black45),
        ),
      ),
    ];
  }

  _content() {
    return [
      Positioned.fill(
        left: 25,
        right: 25,
        child: ListView(
          children: [
            hiSpace(height: 100),
            const Text(
              "账号密码登录",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            hiSpace(height: 40),
            InputWidget(
              "请输入账号",
              onChange: (text) => {
                username = text,
                _checkInput(),
              },
            ),
            hiSpace(height: 10),
            InputWidget(
              "请输入密码",
              obscureText: true,
              onChange: (text) => {
                password = text,
                _checkInput(),
              },
            ),
            hiSpace(height: 45),
            LoginButton(
              "登录",
              enabled: loginEnable,
              onPressed: () => _login(context),
            ),
            hiSpace(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => _jumpRegistration(),
                child: const Text(
                  "注册账号",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }

  void _checkInput() {
    bool enabled;
    if (isNotEmpty(username) && isNotEmpty(password)) {
      enabled = true;
    } else {
      enabled = false;
    }
    setState(() {
      loginEnable = enabled;
      print('loginEnable=$loginEnable');
    });
  }

  _login(context) async {
    try {
      var result = await LoginDao.login(username: username!, password: password!);
      NavigatorUtil.goToHome(context);
      print('登录成功');
    } catch (e) {
      print(e);
    }
  }

  //跳转到注册页面
  _jumpRegistration() async {
    //跳转到接口后台注册账号
    Uri uri = Uri.parse("https://api.geekailab.com/uapi/swagger-ui.html#/Account/registrationUsingPOST");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $uri";
    }
  }
}
