import 'dio_adapter.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';
import '../request/base_request.dart';

class HiNet {
  static HiNet? _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  HiNet._();

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    Object? error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<dynamic> send(BaseRequest request) async {
    printLog('url: ${request.url()}');
    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    // ignore: avoid_print
    print('HiNet: $log');
  }
}
