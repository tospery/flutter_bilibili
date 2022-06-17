import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({super.key, required this.videoModel});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: Text('视频详情: ${widget.videoModel.vid}'));
  }
}
