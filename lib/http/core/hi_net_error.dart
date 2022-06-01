class HTTPError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HTTPError(this.code, this.message, {this.data});
}

class UnloginedError extends HTTPError {
  UnloginedError({int code = 401, String message = '请先登录'})
      : super(code, message);
}

class UnauthorizedError extends HTTPError {
  UnauthorizedError(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}
