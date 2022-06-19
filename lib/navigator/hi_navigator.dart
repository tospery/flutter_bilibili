import 'package:flutter/material.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

typedef RouteChangeListener = Function(RouteStatusInfo current, RouteStatusInfo? pre);

wrapPage(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

enum RouteStatus { login, registration, home, detail, unknown }

RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
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

  static HiNavigator? _instance;

  static HiNavigator getInstance() {
    _instance ??= HiNavigator._();
    return _instance!;
  }

  HiNavigator._();

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

  //   void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
  //   if (currentPages == prePages) return;
  //   var current =
  //       RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
  //   _notify(current);
  // }
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
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
