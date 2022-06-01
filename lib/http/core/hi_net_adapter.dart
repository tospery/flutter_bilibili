import 'package:flutter_bilibili/http/core/hi_net_response.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}