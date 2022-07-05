
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_base_tab_state.dart';
import 'package:flutter_bilibili/http/dao/ranking_dao.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/widget/video_large_card.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({super.key, required this.sort});

  @override
  State<RankingTabPage> createState() => _RankingTabPageState();
}

class _RankingTabPageState extends HiBaseTabState<Ranking, Video, RankingTabPage> {
  
  @override
  get contentChild => ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.only(top: 10),
    itemCount: dataList.length,
    controller: scrollController,
    itemBuilder: (BuildContext context, int index) => VideoLargeCard(video: dataList[index])
  );
  
  @override
  Future<Ranking> getData(int pageIndex) async {
    Ranking result = await RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 20);
    return result;
  }
  
  @override
  List<Video> parseList(Ranking result) {
    return result.list;
  }
}