import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video.dart';

class VideoDetailPage extends StatefulWidget {
  final Video video;

  const VideoDetailPage({super.key, required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: Text('视频详情: ${widget.video.vid}'));
  }
}
