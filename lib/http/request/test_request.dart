import 'package:flutter_bilibili/http/request/http_request.dart';

class TestRequest extends BaseRequest {
  @override
  HTTPMethod httpMethod() {
    return HTTPMethod.get;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'uapi/test/test';
  }
}
