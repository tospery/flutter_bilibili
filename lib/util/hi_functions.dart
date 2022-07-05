import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bilibili/util/hi_types.dart';
import 'package:fluttertoast/fluttertoast.dart';

void hiPrint(log, {String? tag}) {
  if (kDebugMode) {
    print('${tag != null ? '【$tag】' : ''}$log');
  }
}

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;

void showWarnToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

void changeStatusBar(
    {Color color = Colors.white,
    StatusStyle statusStyle = StatusStyle.dark,
    BuildContext? context}) {
  Brightness brightness;
  if (Platform.isIOS) {
    brightness =
        statusStyle == StatusStyle.light ? Brightness.dark : Brightness.light;
  } else {
    brightness =
        statusStyle == StatusStyle.light ? Brightness.light : Brightness.dark;
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness));
}

String durationTransform(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  if (s < 10) {
    return '$m:0$s';
  }
  return '$m:$s';
}

String countFormat(int count) {
  String views = '';
  if (count > 9999) {
    views = '${(count / 10000).toStringAsFixed(2)}万';
  } else {
    views = count.toString();
  }
  return views;
}

Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (BuildContext context, String url) =>
        Container(color: Colors.grey[200]),
    errorWidget: (BuildContext context, String url, dynamic error) =>
        const Icon(Icons.error),
    imageUrl: url,
  );
}

smallIconText(IconData iconData, var text) {
  var style = const TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      '$text',
      style: style,
    ),
  ];
}

borderLine(BuildContext context, {bottom = true, top = false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.grey[200]!);
  return Border(
      bottom: bottom ? borderSide : BorderSide.none,
      top: top ? borderSide : BorderSide.none);
}

SizedBox hiSpace({double width = 1, double height = 1}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

BoxDecoration? bottomBoxShadow() {
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(
      color: Colors.grey[100]!,
      offset: const Offset(0, 5),
      blurRadius: 5.0,
      spreadRadius: 1
    )],
  );
}