import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('首页'),
          MaterialButton(
              child: const Text('详情'),
              onPressed: (){
                HiNavigator.getInstance().onJumpTo(RouteStatus.detail);
              })
        ],
      ),
    );
  }
}
