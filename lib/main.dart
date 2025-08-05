import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';

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
    var widget = Router(routerDelegate: _routeDelegate);
    return MaterialApp(home: widget);
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  // BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];
  VideoModel? videoModel;
  BiliRoutePath? path;

  @override
  Widget build(BuildContext context) {
    pages = [
      pageWrap(
        HomePage(
          onJumpToDetail: (videoModel) {
            this.videoModel = videoModel;
            path = BiliRoutePath.detail();
            notifyListeners();
          },
        ),
      ),
    ];
    if (videoModel != null) {
      pages.add(pageWrap(VideoDetailPage(videoModel: videoModel!)));
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      // ignore: deprecated_member_use
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(BiliRoutePath page) async {
    path = path;
  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}
