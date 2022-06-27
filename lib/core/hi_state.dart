import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

abstract class HiState<T extends StatefulWidget> extends State<T> {

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      hiPrint('页面已销毁，本次setState不执行：${toString()}', tag: 'HiState');
      return;
    }
    super.setState(fn);
  }
  
}