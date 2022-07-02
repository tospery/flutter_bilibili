import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/util/hi_types.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final Video video;

  const VideoDetailPage({super.key, required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  List tabs = ['简介', '评论288'];

  @override
  void initState() {
    super.initState();
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.light);
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            _buildVideoView(),
            InkWell(
              onTap: () {
                Navigator.maybePop(context);
              },
              child: const Text('返回'),
            ),
            _buildTabNavigation(),
          ],
        ),
      ),
    );
  }

  _buildVideoView() {
    var video = widget.video;
    return VideoView(video.url, cover: video.cover);
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
    );
  }
}
