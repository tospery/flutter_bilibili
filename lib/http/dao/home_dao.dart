import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/home_request.dart';
import 'package:flutter_bilibili/model/index.dart';

class HomeDao {
  static get(String categoryName, {int pageIndex = 1, int pageSize = 10}) async {
    HomeRequest request = HomeRequest();
    request.pathExtra = categoryName;
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await HiNet.getInstance().fire(request);
    return Home.fromJson(result['data']);
  }
}