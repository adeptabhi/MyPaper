// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mypaper/app/app_data.dart';
import '../app/app_colors.dart';

snackBarMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: const TextStyle(color: AppColors.white)),
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.green,
    ),
  );
}

void logError(String name, {String type = '', required dynamic msg}) {
  AppData.isDebugMode
      ? log(
          '\x1B[31m$type${type.isNotEmpty ? ':' : ''}$msg\x1B[0m',
          name: '\x1B[37m$name\x1B[0m',
        )
      : print('Vikas($name): $msg');
}

void logInfo(String name, {String type = '', required dynamic msg}) {
  AppData.isDebugMode
      ? log(
          '\x1B[33m$type${type.isNotEmpty ? ':' : ''}$msg\x1B[0m',
          name: '\x1B[37m$name\x1B[0m',
        )
      : print('Vikas($name): $msg');
}

void logSuccess(String name, {String type = '', required dynamic msg}) {
  AppData.isDebugMode
      ? log(
          '\x1B[32m$type${type.isNotEmpty ? ':' : ''}$msg\x1B[0m',
          name: '\x1B[37m$name\x1B[0m',
        )
      : print('Vikas($name): $msg');
}
