import 'package:dio/dio.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';
import '../request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    Response? response;
    DioException? error;
    var options = Options(headers: request.header);
    try {
      if (request.httpMethod() == HttpMethod.get) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.post) {
        response = await Dio().post(
          request.url(),
          data: request.parameter,
          options: options,
        );
      } else if (request.httpMethod() == HttpMethod.delete) {
        response = await Dio().delete(
          request.url(),
          data: request.parameter,
          options: options,
        );
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw HiNetError(
        response?.statusCode ?? -1,
        error.toString(),
        data: await buildResponse(request, response),
      );
    }
    return buildResponse(request, response);
  }

  Future<HiNetResponse<T>> buildResponse<T>(
    BaseRequest request,
    Response? response,
  ) {
    return Future.value(
      HiNetResponse(
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        data: response?.data,
        extra: response,
      ),
    );
  }
}
