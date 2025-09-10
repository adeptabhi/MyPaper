import 'package:flutter/material.dart';

enum DashBottomType { home, tests }

extension DashBottomTypeExtension on DashBottomType {
  IconData get icon {
    switch (this) {
      case DashBottomType.home:
        return Icons.home;
      case DashBottomType.tests:
        return Icons.quiz;
    }
  }

  String get label {
    switch (this) {
      case DashBottomType.home:
        return 'Home';
      case DashBottomType.tests:
        return 'Tests';
    }
  }
}
