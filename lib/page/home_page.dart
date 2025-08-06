import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/utils/hi_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(
      listener = (current, pre) {
        if (widget == current.page || current.page is HomePage) {
          hiPrint('打开了首页:onResume');
        } else if (widget == pre?.page || pre?.page is HomePage) {
          hiPrint('首页:onPause');
        }
      },
    );
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

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
