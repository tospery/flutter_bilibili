import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/video_detail_dao.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/util/hi_types.dart';
import 'package:flutter_bilibili/widget/expandable_content.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_header.dart';
import 'package:flutter_bilibili/widget/video_large_card.dart';
import 'package:flutter_bilibili/widget/video_toolbar.dart';
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
  Video? video;
  VideoDetail? videoDetail;
  List<Video> videoList = [];

  @override
  void initState() {
    super.initState();
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.light);
    _controller = TabController(length: tabs.length, vsync: this);
    video = widget.video;
    _loadDetail();
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
        child: video?.url != null
            ? Column(
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
                  Flexible(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        _buildDetailList(),
                        const Text('敬请期待...')
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  _buildVideoView() {
    return VideoView(video!.url, cover: video!.cover);
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

  _buildDetailList() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        ...buildContents(),
        ...buildVideoList(),
      ],
    );
  }

  buildContents() {
    return [
      VideoHeader(owner: video!.owner),
      ExpandableContent(video: video!),
      VideoToolBar(
        video: video!,
        videoDetail: videoDetail,
        onLike: _doLike,
        onUnLike: _doUnLike,
        onFavorite: _doFavorite,
      )
    ];
  }

  buildVideoList() {
    return videoList.map((v) => VideoLargeCard(video: v));
  }

  void _loadDetail() async {
    try {
      VideoDetail result = await VideoDetailDao.get(video!.vid);
      setState(() {
        videoDetail = result;
        video = result.videoInfo;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      hiPrint(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      hiPrint(e);
      showWarnToast(e.message);
    }
  }

  void _doLike() {}

  void _doUnLike() {}

  void _doFavorite() async {
    try {
      var result =
          await VideoDetailDao.favorite(video!.vid, !videoDetail!.isFavorite);
      hiPrint(result);
      videoDetail!.isFavorite = !videoDetail!.isFavorite;
      if (videoDetail!.isFavorite) {
        video!.favorite += 1;
      } else {
        video!.favorite -= 1;
      }
      setState(() {
        video = video;
        videoDetail = videoDetail;
      });
    } on HiNetError catch (e) {
      hiPrint(e);
      showWarnToast(e.message);
    }
  }
}
