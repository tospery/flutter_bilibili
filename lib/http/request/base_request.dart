enum HttpMethod { get, post, delete }

abstract class BaseRequest {
  var useHttps = true;
  var pathExtra = '';
  var parameter = <String, String>{};
  Map<String, dynamic> header = {};

  String host() {
    return "api.devio.org";
  }

  String? path();
  HttpMethod httpMethod();
  bool needLogin();

  String url() {
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
    return uri.toString();
  }

  BaseRequest add(String k, Object? v) {
    parameter[k] = v.toString();
    return this;
  }

  BaseRequest addHeader(String k, Object? v) {
    header[k] = v.toString();
    return this;
  }
}
