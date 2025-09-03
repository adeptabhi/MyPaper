import 'package:flutter/material.dart';

class RouteObservers extends NavigatorObserver {
  static RouteObservers inst = RouteObservers();
  String currentRouteName = '';
  @override
  void didPush(Route route, Route? previousRoute) {
    currentRouteName = route.settings.name ?? '';
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    currentRouteName = previousRoute?.settings.name ?? '';
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    currentRouteName = newRoute?.settings.name ?? '';
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
