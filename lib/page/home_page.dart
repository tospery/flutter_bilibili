import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("首页"),
          MaterialButton(
            onPressed: () {
              HiNavigator.getInstance().onJumpTo(
                RouteStatus.detail,
                args: {'video': VideoModel(1001)},
              );
            },
            child: const Text("详情"),
          ),
        ],
      ),
    );
  }
}
