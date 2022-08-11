import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/util/hi_constants.dart';

enum HttpMethod { get, post, delete }

abstract class BaseRequest {
  var useHttps = true;
  var pathExtra = '';
  var parameter = <String, String>{};
  Map<String, dynamic> header = {
    HiConstants.authTokenKey: HiConstants.authTokenValue,
    HiConstants.courseFlagKey: HiConstants.courseFlagValue
  };

  String host() {
    return "api.devio.org";
  }

  String? path();
  HttpMethod httpMethod();
  bool needLogin();

  String urlString() {
    Uri uri;
    var path = this.path() ?? '';

    if (pathExtra.isNotEmpty) {
      if (path.endsWith('/')) {
        path = '$path$pathExtra';
      } else {
        path = '$path/$pathExtra';
      }
    }

    if (useHttps) {
      uri = Uri.https(host(), path, parameter);
    } else {
      uri = Uri.http(host(), path, parameter);
    }
    if (needLogin()) {
      set(LoginDao.boardingPassKey, LoginDao.getBoardingPass());
    }
    return uri.toString();
  }

  BaseRequest add(String k, Object? v) {
    parameter[k] = v.toString();
    return this;
  }

  BaseRequest set(String k, Object? v) {
    header[k] = v.toString();
    return this;
  }
}
