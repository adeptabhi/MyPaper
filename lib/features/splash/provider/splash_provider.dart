// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mypaper/routes/route_name.dart';

class SplashProvider {
  BuildContext context;
  SplashProvider({required this.context}) {
    initState();
  }
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, RouteName.dash);
    });
  }
}
