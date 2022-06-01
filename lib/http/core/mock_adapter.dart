// class MockAdapter extends HiNetAdapter {
//   @override
//   Future<HiNetResponse<T>> send<T>(BaseRequest request) {
//     return Future<HiNetResponse>.delayed(Duration(milliseconds: 1000), () {
//       return HiNetResponse(
//           data: {"code":0, "message": 'success'}, statusCode: 403);
//     });
//   }
// }

import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/core/hi_net_response.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNetResponse>.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse(statusCode: 403);
    });
  }
  
}