import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

enum StatusStyle { dark, light }

class NavigationBarPlus extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBarPlus(
      {super.key,
      this.statusStyle = StatusStyle.dark,
      this.color = Colors.white,
      this.height = 46,
      required this.child});

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
    FlutterStatusbarManager.setColor(color, animated: false);
    FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.dark ? StatusBarStyle.DARK_CONTENT : StatusBarStyle.LIGHT_CONTENT);
  }
}
