import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/utils/color.dart';
import 'package:flutter_bilibili/utils/hi_functions.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({super.key});

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : const Scaffold(body: Center(child: CircularProgressIndicator()));
        return MaterialApp(
          home: widget,
          theme: ThemeData(primarySwatch: white),
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {
            videoModel = args!['video'];
          }
          notifyListeners();
        },
      ),
    );
  }

  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  RouteStatus _routeStatus = RouteStatus.home;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    // ignore: prefer_typing_uninitialized_variables
    var page;
    if (routeStatus == RouteStatus.home) {
      pages.clear();
      page = wrapPage(HomePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = wrapPage(VideoDetailPage(videoModel: videoModel!));
    } else if (routeStatus == RouteStatus.registration) {
      page = wrapPage(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = wrapPage(LoginPage());
    }

    tempPages = [...tempPages, page];
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    // ignore: deprecated_member_use
    return WillPopScope(
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        // ignore: deprecated_member_use
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast('请先登录');
                return false;
              }
            }
          }
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
      onWillPop: () async =>
          !(await navigatorKey.currentState?.maybePop() ?? false),
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath page) async {}
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}
