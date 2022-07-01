import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

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
      appBar: AppBar(),
      body: Column(
        children: [
          Text('视频详情: ${widget.video.vid}'),
          Text('视频标题: ${widget.video.title}'),
          _videoView(),
        ],
      ),
    );
  }

  _videoView() {
    var video = widget.video;
    return VideoView(video.url, cover: video.cover);
  }
}
