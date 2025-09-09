import 'package:flutter/material.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/features/home/provider/home_provider.dart';
import 'package:mypaper/features/home/view/home_view.dart';
import 'package:mypaper/features/paper/model/paper_nav_mdl.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/view/paper_view.dart';
import 'package:mypaper/features/splash/provider/splash_provider.dart';
import 'package:mypaper/features/splash/view/splash_view.dart';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_name.dart';
import 'package:provider/provider.dart';

class Routes {
  static PageRouteBuilder rightToLeftSlide({
    required RouteSettings settings,
    required Widget builder,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => builder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    logInfo('Route', msg: '${settings.name}');
    switch (settings.name) {
      case RouteName.splash:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) => Provider(
            lazy: false,
            create: (context) => SplashProvider(context: context),
            child: const SplashView(),
          ),
        );

      case RouteName.home:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
                create: (context) => HomeProvider(context: context),
                child: const HomeView(),
              ),
        );

      case RouteName.paper:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
                create: (context) => PaperProvider(
                  context: context,
                  paperMdl: settings.arguments as PaperNavMdl,
                ),
                child: const PaperView(),
              ),
        );
    }
    return null;
  }
}
