 import 'package:flutter/foundation.dart';

void hiPrint(log, {String? tag}) {
  if (kDebugMode) {
    print('${tag != null ? '【$tag】' : ''}$log');
  }
}