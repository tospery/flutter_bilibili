import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNet {
  static HiNet? _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  HiNet._();

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    printLog(result);
    return result;
  }

  Future<dynamic> send(BaseRequest request) async {
    printLog('url: ${request.urlString()}');
    printLog('method: ${request.httpMethod()}');
    request.set('token', '123');
    printLog('header: ${request.header}');
    return Future.value({
      'statusCode': 200,
      'data': {'code': 0, 'message': 'success'}
    });
  }

  void printLog(log) {
    // ignore: avoid_print
    print('HiNet: $log');
  }
}
