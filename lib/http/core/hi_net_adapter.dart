import 'dart:convert';
import 'package:flutter_bilibili/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

class HiNetResponse<T> {
  int? statusCode;
  String? statusMessage;
  T? data;
  late dynamic extra;
  BaseRequest request;

  HiNetResponse({
    required this.request,
    this.statusCode,
    this.statusMessage,
    this.data,
    this.extra,
  });

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
