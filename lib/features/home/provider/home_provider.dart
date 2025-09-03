// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';

class HomeProvider {
  BuildContext context;
  HomeProvider({required this.context});
  final TextEditingController conExamCode = TextEditingController(text: '5698');
}
