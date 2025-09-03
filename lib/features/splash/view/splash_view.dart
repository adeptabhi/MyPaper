// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/app_data.dart';
import 'package:mypaper/app/theme.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 2),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, -value * 20),
                    child: Center(
                      child: Image.asset(
                        '${AppData.assets}app_icon.png',
                        width: 160,
                        height: 160,
                        color: AppColors.white,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 2),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, -value * 20),
                    child: Text(
                      'My Paper',
                      style: textStyle(
                        fontSize: 27,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
