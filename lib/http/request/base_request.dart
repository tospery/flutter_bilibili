enum HttpMethod { get, post, delete }

abstract class BaseRequest {
  var useHttps = true;
  var parameter = <String, String>{};
  var header = <String, dynamic>{};

  String host() {
    return "api.devio.org";
  }

  String? path();
  HttpMethod httpMethod();
  bool needLogin();

  String urlString() {
    Uri uri;
    var path = this.path();
    if (useHttps) {
      uri = Uri.https(host(), path ?? '', parameter);
    } else {
      uri = Uri.http(host(), path ?? '', parameter);
    }
    return uri.toString();
  }

  BaseRequest add(String k, Object v) {
    parameter[k] = v.toString();
    return this;
  }

  BaseRequest set(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
