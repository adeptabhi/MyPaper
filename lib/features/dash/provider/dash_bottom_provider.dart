import 'package:flutter/widgets.dart';
import 'package:mypaper/features/dash/enum/bottom_type.dart';
import 'package:mypaper/features/dash/provider/dash_provider.dart';
import 'package:provider/provider.dart';

class DashBottomProvider {
  BuildContext context;
  DashBottomProvider({required this.context});
  void onTap(BottomType type) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<DashProvider>().updateBottomType(type);
  }
}
