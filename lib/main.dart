import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/routes/app_life_cycle.dart';
import 'package:mypaper/routes/route_name.dart';
import 'package:mypaper/routes/route_observers.dart';
import 'package:mypaper/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(state) => appLifeCycle(state);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[RouteObservers.inst],
      navigatorKey: navigatorKey,
      title: 'MyPaper',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: RouteName.splash,
    );
  }
}
