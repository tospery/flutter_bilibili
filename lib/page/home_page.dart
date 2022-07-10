import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/model/banner.dart';
import 'package:flutter_bilibili/model/category.dart';
import 'package:flutter_bilibili/model/home.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
import 'package:flutter_bilibili/util/hi_types.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/loading_container.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // final ValueChanged<int>? onJumpTo;
  final ValueChanged<int>? onJumpTo;

  const HomePage({super.key, this.onJumpTo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
// ignore: prefer_typing_uninitialized_variables
  var listener;

  List<Category> categoryList = [];
  List<Banner> bannerList = [];
  late TabController _controller;
  bool _isLoading = true;
  // Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
        hiPrint('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        hiPrint('首页:onPause');
      }
      // 当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is VideoDetailPage && current.page is! ProfilePage) {
        var statusStyle = StatusStyle.dark;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });
    loadData();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeProvider>().darModeChange();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    hiPrint('$state', tag: 'didChangeAppLifecycleState');
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        //fix Android压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
            NavigationBarPlus(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.dark,
            ),
            Container(
              decoration: bottomBoxShadow(context),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return HiTab(
      categoryList.map<Tab>((tab) {
        return Tab(
          text: tab.name,
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
  }

  void loadData() async {
    try {
      Home result = await HomeDao.get('推荐');
      hiPrint('loadData():$result');
      _controller =
          TabController(length: result.categoryList.length, vsync: this);
      setState(() {
        categoryList = result.categoryList;
        bannerList = result.bannerList;
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      hiPrint(e);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      hiPrint(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                height: 46,
                width: 46,
                image: AssetImage('res/image/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _mockCrash();
            },
            child: const Icon(
              Icons.explore_outlined,
              color: Colors.grey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  void _mockCrash() {
    // //使用try-catch捕获同步异常
    // try {
    //   throw StateError('This is a dart exception.');
    // } catch (e) {
    //   print(e);
    // }
    // //使用catchError捕获异步异常
    // Future.delayed(Duration(seconds: 1))
    //     .then((value) =>
    //         throw StateError('This is first Dart exception in Future.'))
    //     .catchError((e) => print(e));

    // try {
    //   await Future.delayed(Duration(seconds: 1))
    //       .then((value) =>
    //           throw StateError('This is second Dart exception in Future.'))
    //       .catchError((e) => print(e));
    // } catch (e) {
    //   print(e);
    // }
    // runZonedGuarded(() {
    //   throw StateError('runZonedGuarded:This is a dart exception.');
    // }, (e, s) => print(e));
    // runZonedGuarded(() {
    //   Future.delayed(Duration(seconds: 1)).then((value) => throw StateError(
    //       'runZonedGuarded:This is first Dart exception in Future.'));
    // }, (e, s) => print(e));
    // throw StateError('main:This is second Dart exception.');
  }
}
