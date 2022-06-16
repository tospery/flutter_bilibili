 import 'package:flutter/foundation.dart';

void hiPrint(log, {String? tag}) {
  if (kDebugMode) {
    print('${tag != null ? '【$tag】' : ''}$log');
  }
}

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;