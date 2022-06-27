import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/model/banner.dart';
import 'package:flutter_bilibili/model/category.dart';
import 'package:flutter_bilibili/model/home.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:flutter_bilibili/core/hi_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
// ignore: prefer_typing_uninitialized_variables
  var listener;

  List<Category> categoryList = [];
  List<Banner> bannerList = [];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
        hiPrint('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        hiPrint('首页:onPause');
      }
    });
    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
            controller: _controller,
            children: categoryList.map((tab) {
              return HomeTabPage(
                categoryName: tab.name,
                bannerList: tab.name == '推荐' ? bannerList : null,
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15),
        ),
        tabs: categoryList.map<Tab>((tab) {
          return Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList());
  }

  void loadData() async {
    try {
      Home result = await HomeDao.get('推荐');
      hiPrint('loadData():$result');
        _controller = TabController(
            length: result.categoryList.length, vsync: this);
      setState(() {
        categoryList = result.categoryList;
        bannerList = result.bannerList.cast<Banner>();
      });
    } on NeedAuth catch (e) {
      hiPrint(e);
    } on HiNetError catch (e) {
      hiPrint(e);
    }
  }
}
