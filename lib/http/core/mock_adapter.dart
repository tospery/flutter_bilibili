import 'hi_net_adapter.dart';
import '../request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse(
        request: request,
        statusCode: 403,
        data: {'code': 0, 'message': 'success'} as T,
      );
    });
  }
}
