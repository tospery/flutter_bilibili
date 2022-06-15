import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
      ),
      body: Container(
        child: ListView(children: const [
          LoginInput('用户名', '请输入用户名'),
          LoginInput('密码', '请输入密码'),
        ]),
      ),
      );
  }
}