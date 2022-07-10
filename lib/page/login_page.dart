import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/widget/app_bar.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappBar('密码登录', '注册', () {
        // context.read<ThemeProvider>().setTheme(ThemeMode.dark);
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }),
      body: ListView(
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            '用户名',
            '请输入用户名',
            onChanged: (text) {
              username = text;
              checkInput();
            },
          ),
          LoginInput(
            '密码',
            '请输入密码',
            obscureText: true,
            onChanged: (text) {
              password = text;
              checkInput();
            },
            focusChanged: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: LoginButton(
              '登录',
              enable: loginEnable,
              onPressed: send,
            ),
          ),
        ],
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(username) && isNotEmpty(password)) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(username ?? "", password ?? "");
      hiPrint(result);
      if (result['code'] == 0) {
        showToast('登录成功');
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }
}
