import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/widget/app_bar.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappBar('注册', '登录', (){
        hiPrint('clicked right button');
      }),
      body: ListView(children: [
        LoginEffect(protect: protect),
        LoginInput(
          '用户名',
          '请输入用户名',
          onChanged: (text) {},
        ),
        LoginInput(
          '密码',
          '请输入密码',
          lineStretch: true,
          obscureText: true,
          onChanged: (text) {

          },
          focusChanged: (focus) {
            setState(() {
              protect = focus;
            });
          },
        ),
      ]),
    );
  }
}
