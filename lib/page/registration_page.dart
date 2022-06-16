import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/widget/app_bar.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumpToLogin;

  const RegistrationPage({super.key, this.onJumpToLogin});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? username;
  String? password;
  String? rePassword;
  String? imoocId = '10762875';
  String? orderId = '0809';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappBar('注册', '登录', widget.onJumpToLogin),
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
            lineStretch: true,
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
          LoginInput(
            '确认密码',
            '请再次输入密码',
            lineStretch: true,
            obscureText: true,
            onChanged: (text) {
              rePassword = text;
              checkInput();
            },
            focusChanged: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          LoginInput(
            '摹客网ID',
            '请输入你的慕课网用户ID',
            keyboardType: TextInputType.number,
            onChanged: (text) {
              imoocId = text;
              checkInput();
            },
          ),
          LoginInput(
            '课程订单号',
            '请输入课程订单号后四位',
            keyboardType: TextInputType.number,
            onChanged: (text) {
              orderId = text;
              checkInput();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: _loginButton(),
          )
        ],
      ),
    );
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          checkParams();
        }
      },
      child: const Text('注册'),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(username) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId?.length != 4) {
      tips = '请输入订单号的后四位';
    }
    if (tips != null) {
      hiPrint(tips);
      return;
    }
    send();
  }

  void send() async {
    try {
      var result = await LoginDao.register(
          username ?? "", password ?? "", imoocId ?? "", orderId ?? "");
      hiPrint(result);
      if (result['code'] == 0) {
        hiPrint('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin!();
        }
      } else {
        hiPrint(result['msg']);
      }
    } on NeedAuth catch (e) {
      hiPrint(e);
    } on HiNetError catch (e) {
      hiPrint(e);
    }
  }
}
