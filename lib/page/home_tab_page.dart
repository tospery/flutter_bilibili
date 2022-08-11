import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bilibili/core/hi_base_tab_state.dart';
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

class _HomeTabPageState
    extends HiBaseTabState<Home, Video, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    hiPrint(widget.categoryName);
    hiPrint(widget.bannerList);
  }

  _banner(List<Banner> bannerList) {
    return HiBanner(bannerList, padding: const EdgeInsets.only(left: 5, right: 5));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      crossAxisCount: 2,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        //有banner时第一个item位置显示banner
        if (widget.bannerList != null && index == 0) {
          return Padding(padding: const EdgeInsets.only(bottom: 8), child: _banner(widget.bannerList!));
        } else {
          return VideoCard(video: dataList[index]);
        }
      },
      staggeredTileBuilder: (int index) {
        if (widget.bannerList != null && index == 0) {
          return const StaggeredTile.fit(2);
        } else {
          return const StaggeredTile.fit(1);
        }
      });

  @override
  Future<Home> getData(int pageIndex) async {
    Home result = await HomeDao.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<Video> parseList(Home result) {
    return result.videoList;
  }
}

