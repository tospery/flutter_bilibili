import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

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
    HiNavigator.getInstance().addListener(listener = (current, pre){
      if (widget == current.page || current.page is HomePage) {
        hiPrint('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
hiPrint('首页:onPause');
      }
    });
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
        children: [
          const Text('首页'),
          MaterialButton(
              child: const Text('详情'),
              onPressed: (){
                HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {'videoMo': VideoModel(123)});
              })
        ],
      ),
    );
  }
}
