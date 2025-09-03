import 'package:flutter/widgets.dart';
import 'package:mypaper/routes/route_name.dart';

class HomeBottomProvider {
  BuildContext context;
  String index = 'home';
  HomeBottomProvider({required this.context, required this.index});
  void onTap(String check) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (check != index) {
      Navigator.popUntil(
        context,
        (route) => route.settings.name == RouteName.home,
      );
      switch (check) {
        case 'Home':
          break;
        case 'My Exam':
          Navigator.pushNamed(context, RouteName.myExam);
          break;
      }
    }
  }
}
