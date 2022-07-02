import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/util/hi_types.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final Video video;

  const VideoDetailPage({super.key, required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: Platform.isIOS,
        context: context,
        child: Column(
          children: [
            NavigationBarPlus(
              color: Colors.black,
              statusStyle: StatusStyle.light,
              height: Platform.isAndroid ? 0 : 46,
              child: null,
            ),
            _videoView(),
            InkWell(
              onTap: () {
                Navigator.maybePop(context);
              },
              child: const Text('返回'),
            ),
            Text('视频详情: ${widget.video.vid}'),
            Text('视频标题: ${widget.video.title}'),
          ],
        ),
      ),
    );
  }

  _videoView() {
    var video = widget.video;
    return VideoView(video.url, cover: video.cover);
  }
}
