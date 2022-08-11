import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/bottom_navigator.dart';
import 'package:flutter_bilibili/page/dark_mode_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

typedef RouteChangeListener = Function(RouteStatusInfo current, RouteStatusInfo? pre);

wrapPage(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

enum RouteStatus { login, registration, home, detail, unknown, darkMode }

RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else if (page.child is DarkModePage) {
    return RouteStatus.darkMode;
  } else {
    return RouteStatus.unknown;
  }
}

int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (var i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

class HiNavigator extends _RouteJumpListener {

  RouteJumpListener? _routeJump;
  final List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;
  RouteStatusInfo? _bottomTab;

  static HiNavigator? _instance;

  static HiNavigator getInstance() {
    _instance ??= HiNavigator._();
    return _instance!;
  }

  HiNavigator._();

  RouteStatusInfo? getCurrent() {
    return _current;
  }

  //   Future<bool> openH5(String url) async {
  //   var result = await canLaunch(url);
  //   if (result) {
  //     return await launch(url);
  //   } else {
  //     return Future.value(false);
  //   }
  // }
  
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJump = routeJumpListener;
  }

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab!;
    }

    hiPrint('current: ${current.page}', tag: 'hi_navigator');
    hiPrint('pre: ${_current?.page}', tag: 'hi_navigator');
    for (var listener in _listeners) {
      listener(current, _current);
    }
    _current = current;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump?.onJumpTo(routeStatus, args: args);
  }

}
