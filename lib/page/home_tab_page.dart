
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<Banner>? bannerList;

  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.categoryName);
  }
}