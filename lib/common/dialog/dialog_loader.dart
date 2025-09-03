// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';

Future dialogLoader(BuildContext context, {String title = 'Please wait...'}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SpinKitCircle(color: AppColors.blue, size: 75),
              if (title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    title,
                    style: textStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 13,
                    ).copyWith(decoration: TextDecoration.none),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
