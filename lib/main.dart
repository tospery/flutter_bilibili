import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/model/video.dart';
import 'package:flutter_bilibili/navigator/bottom_navigator.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/dark_mode_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/provider/hi_provider.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HiCache.preInit(),
      builder: (context, snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
        return MultiProvider(
          providers: topProviders,
          child: Consumer<ThemeProvider>(
            builder: (BuildContext context, ThemeProvider themeProvider,
                Widget? child) {
              return MaterialApp(
                home: widget,
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
              );
            },
          ),
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  List<MaterialPage> pages = [];
  Video? video;
  RouteStatus _routeStatus = RouteStatus.home;

  // //????????????????????????

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //????????????????????????
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        video = args!['video'];
      }
      notifyListeners();
    }));
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (video != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //?????????????????????????????????????????????????????????????????????????????????????????????
      //tips ?????????????????????????????????????????????????????????????????????????????????????????????????????????
      tempPages = tempPages.sublist(0, index);
    }
    // ignore: prefer_typing_uninitialized_variables
    var page;
    if (routeStatus == RouteStatus.home) {
      //???????????????????????????????????????????????????????????????????????????
      pages.clear();
      page = wrapPage(const BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = wrapPage(VideoDetailPage(video: video!));
    } else if (routeStatus == RouteStatus.registration) {
      page = wrapPage(const RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = wrapPage(const LoginPage());
    } else if (routeStatus == RouteStatus.darkMode) {
      page = wrapPage(const DarkModePage());
    }
    //?????????????????????????????????pages???????????????????????????????????????
    tempPages = [...tempPages, page];
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              //??????????????????????????????
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showWarnToast('????????????');
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
            !(await navigatorKey.currentState?.maybePop() ?? false));
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}
