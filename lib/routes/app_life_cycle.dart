import 'dart:ui';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_observers.dart';

final Map<String, dynamic> activeScreens = {};

void appLifeCycle(AppLifecycleState state) async {
  logInfo('appLifeCycle/stateName', msg: state.name);
  logInfo(
    'appLifeCycleServices',
    type: 'currentScreen',
    msg: RouteObservers.inst.currentRouteName,
  );
  // ignore: unused_local_variable
  var scr = activeScreens[RouteObservers.inst.currentRouteName];

  switch (state) {
    case AppLifecycleState.resumed:
      switch (RouteObservers.inst.currentRouteName) {
        // case RouteName.dash:
        //   scr as DashScrState;
      }
      break;
    case AppLifecycleState.inactive:
      break;
    case AppLifecycleState.paused:
      break;
    case AppLifecycleState.detached:
      break;
    case AppLifecycleState.hidden:
      break;
  }
}
