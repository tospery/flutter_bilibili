enum HTTPMethod { get, post, delete }

abstract class BaseRequest {
  var useHttps = true;
  var parameters = <String, String>{};
  var header = <String, dynamic>{};

  HTTPMethod httpMethod();
  String path();
  bool needLogin();

  String host() {
    return 'api.devio.org';
  }

  String url() {
    Uri uri;
    if (useHttps) {
      uri = Uri.https(host(), path(), parameters);
    } else {
      uri = Uri.http(host(), path(), parameters);
    }
    // ignore: avoid_print
    print('url: ${uri.toString()}');
    return uri.toString();
  }

  BaseRequest add(String k, Object v) {
    parameters[k] = v.toString();
    return this;
  }

  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
