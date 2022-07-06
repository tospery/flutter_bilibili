import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class HiDefend {
  run(Widget app) {
    //框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      //线上环境，走上报逻辑
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        //开发期间，走Console抛出
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      runApp(app);
    }, (e, s) => _reportError(e, s));
  }

  ///通过接口上报异常
  _reportError(Object error, StackTrace s) {
    hiPrint('kReleaseMode:$kReleaseMode');
    hiPrint('catch error:$error');
  }
}