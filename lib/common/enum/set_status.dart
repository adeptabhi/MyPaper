import 'package:flutter/material.dart';

enum SetStatus { pending, completed }

extension SetStatusTheme on SetStatus {
  Color get backgroundColor {
    switch (this) {
      case SetStatus.pending:
        return Colors.orange.shade50;
      case SetStatus.completed:
        return Colors.green.shade50;
    }
  }

  Color get borderColor {
    switch (this) {
      case SetStatus.pending:
        return Colors.orange;
      case SetStatus.completed:
        return Colors.green;
    }
  }

  Color get textColor {
    switch (this) {
      case SetStatus.pending:
        return Colors.orange;
      case SetStatus.completed:
        return Colors.green;
    }
  }
}
