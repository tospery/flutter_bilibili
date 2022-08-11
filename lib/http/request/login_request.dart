
import 'package:flutter_bilibili/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.post;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String? path() {
    return '/uapi/user/login';
  }

}
