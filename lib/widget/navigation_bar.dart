import 'package:flutter/material.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/util/hi_types.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class NavigationBarPlus extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const NavigationBarPlus(
      {Key? key,
        this.statusStyle = StatusStyle.dark,
        this.color = Colors.white,
        this.height = 46,
        this.child})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarPlus> {
  // ignore: prefer_typing_uninitialized_variables
  var _statusStyle;
  // ignore: prefer_typing_uninitialized_variables
  var _color;

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.darkBg;
      _statusStyle = StatusStyle.light;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusBarInit();
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
      child: widget.child,
    );
  }

  void _statusBarInit() {
    //沉浸式状态栏
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
