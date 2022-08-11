import 'package:flutter/material.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:underline_indicator/underline_indicator.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

///顶部tab切换组件
class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const HiTab(this.tabs,
      {Key? key,
        this.controller,
        this.fontSize = 13,
        this.borderWidth = 2,
        this.insets = 15,
        this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    // ignore: no_leading_underscores_for_local_identifiers
    var _unselectedLabelColor =
    themeProvider.isDark() ? Colors.white70 : unselectedLabelColor;
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: primary,
        unselectedLabelColor: _unselectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.square,
            borderSide: BorderSide(color: primary, width: borderWidth),
            insets: EdgeInsets.only(left: insets, right: insets)),
        tabs: tabs);
  }
}
