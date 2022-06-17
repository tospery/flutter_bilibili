import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';

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
    HiCache.preInit();
    var widget = Router(
      routerDelegate: _routeDelegate,
    );
    return MaterialApp(
      home: widget,
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  BiliRoutePath? path;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    pages = [
      wrapPage(HomePage(onJumpToDetail: (videoModel) {
        this.videoModel = videoModel;
        notifyListeners();
      })),
      if (videoModel != null) wrapPage(VideoDetailPage(videoModel: videoModel!))
    ];
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
    path = configuration;
  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}

wrapPage(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
