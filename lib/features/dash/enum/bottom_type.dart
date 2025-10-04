import 'package:flutter/material.dart';

enum BottomType { home, bookmark, error }

extension BottomTypeExtension on BottomType {
  BottomType get change =>
      this == BottomType.home ? BottomType.bookmark : BottomType.home;
  IconData get icon {
    switch (this) {
      case BottomType.home:
        return Icons.home;
      case BottomType.bookmark:
        return Icons.bookmark;
      case BottomType.error:
        return Icons.error;
    }
  }

  String get label {
    switch (this) {
      case BottomType.home:
        return 'Home';
      case BottomType.bookmark:
        return 'Bookmark';
      case BottomType.error:
        return 'Error';
    }
  }
}
