import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/util/hi_types.dart';

class NavigationBarPlus extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const NavigationBarPlus(
      {super.key,
      this.statusStyle = StatusStyle.dark,
      this.color = Colors.white,
      this.height = 46,
     this.child});

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }
  
  void _statusBarInit() {
    changeStatusBar(color: color, statusStyle: statusStyle);
  }
}
