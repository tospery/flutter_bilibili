import '../../db/hi_cache.dart';
import '../../utils/hi_functions.dart';
import '../core/hi_net.dart';
import '../request/base_request.dart';
import '../request/login_request.dart';
import '../request/registration_request.dart';

class LoginDao {
  static const boardingPassKey = 'boarding-pass';
  static login(String username, String password) {
    return _send(username, password);
  }

  static register(
    String username,
    String password,
    String imoocId,
    String orderId,
  ) {
    return _send(username, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(
    String username,
    String password, {
    String? imoocId,
    String? orderId,
  }) async {
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
    hiPrint(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(boardingPassKey, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(boardingPassKey);
  }
}
