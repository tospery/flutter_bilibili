import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';
import 'package:flutter_bilibili/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<Banner>? bannerList;

  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> with AutomaticKeepAliveClientMixin {
  List<Video> videoList = [];
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: videoList.length,
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          itemBuilder: (BuildContext context, int index) {
            if (widget.bannerList != null && index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _banner(),
              );
            }
            return VideoCard(video: videoList[index]);
          },
          staggeredTileBuilder: (index) {
            if (widget.bannerList != null && index == 0) {
              return const StaggeredTile.fit(2);
            }
            return const StaggeredTile.fit(1);
          }),
    );
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: HiBanner(widget.bannerList!),
    );
  }

  void _loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      Home result = await HomeDao.get(widget.categoryName,
          pageIndex: currentIndex, pageSize: 10);
      setState(() {
        if (loadMore) {
          if (result.videoList.isNotEmpty) {
            videoList = [...videoList, ...result.videoList];
            pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });
    } on NeedAuth catch (e) {
      hiPrint(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      hiPrint(e);
      showWarnToast(e.message);
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}
