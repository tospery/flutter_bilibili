import 'dart:convert';
import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNetResponse<T> {
  BaseRequest? request;
  int statusCode;
  String? statusMessage;
  T data;
  dynamic extra;

  HiNetResponse({
    required this.statusCode,
    required this.data,
    this.statusMessage,
    this.extra,
    this.request,
  });

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}