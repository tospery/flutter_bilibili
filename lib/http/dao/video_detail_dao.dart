import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/cancel_favorite_request.dart';
import 'package:flutter_bilibili/http/request/favorite_request.dart';
import 'package:flutter_bilibili/http/request/video_detail_request.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class VideoDetailDao {

  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathExtra = vid;
    var result = await HiNet.getInstance().fire(request);
    hiPrint(result);
    return VideoDetail.fromJson(result['data']);
  }

  static favorite(String vid, bool favorite) async {
    BaseRequest request = favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathExtra = vid;
    var result = await HiNet.getInstance().fire(request);
    hiPrint(result);
    return result;
  }

}
