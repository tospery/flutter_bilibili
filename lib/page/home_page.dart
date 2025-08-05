import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel> onJumpToDetail;

  const HomePage({super.key, required this.onJumpToDetail});

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
            onPressed: () => widget.onJumpToDetail(VideoModel(1001)),
            child: const Text("详情"),
          ),
        ],
      ),
    );
  }
}
