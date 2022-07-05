import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/ranking_request.dart';
import 'package:flutter_bilibili/model/ranking.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class RankingDao {
  static get(String sort, {int pageIndex = 1, int pageSize = 10}) async {
    RankingRequest request = RankingRequest();
    request.add('sort', sort).add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await HiNet.getInstance().fire(request);
    hiPrint(result);
    return Ranking.fromJson(result['data']);
  }
}