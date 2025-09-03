import 'package:flutter/material.dart';

void dialogClose(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
