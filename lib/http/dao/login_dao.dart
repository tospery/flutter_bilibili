import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = 'boarding-pass';
  static login(String username, String password) {
    _send(username, password);
  }

  static register(
      String username, String password, String imoocId, String orderId) {
    _send(username, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String username, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }

    request
        .add('userName', username)
        .add('password', password)
        .add('imoocId', imoocId)
        .add('orderId', orderId);
    var result = await HiNet.getInstance().fire(request);
    // ignore: avoid_print
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
