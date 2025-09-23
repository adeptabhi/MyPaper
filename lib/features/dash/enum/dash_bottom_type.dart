import 'package:flutter/material.dart';

enum DashBottomType { home, tests, error }

extension DashBottomTypeExtension on DashBottomType {
  DashBottomType get change =>
      this == DashBottomType.home ? DashBottomType.tests : DashBottomType.home;
  IconData get icon {
    switch (this) {
      case DashBottomType.home:
        return Icons.home;
      case DashBottomType.tests:
        return Icons.quiz;
      case DashBottomType.error:
        return Icons.error;
    }
  }

  String get label {
    switch (this) {
      case DashBottomType.home:
        return 'Home';
      case DashBottomType.tests:
        return 'Tests';
      case DashBottomType.error:
        return 'Error';
    }
  }
}
