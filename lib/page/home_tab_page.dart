import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bilibili/model/banner.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';

class HomeTabPage extends StatefulWidget {

  final String categoryName;
  final List<Banner>? bannerList;
  const HomeTabPage({super.key, required this.categoryName, this.bannerList});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [if (widget.bannerList != null) _banner()],
    );
  }

  _banner() {
    return Padding(padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(widget.bannerList!),
    );
  }
}
