import 'package:flutter/material.dart';
import 'package:mypaper/app/app_data.dart';

enum DialogType { cancel, clear, delete, exit, confirmation, info }

extension DialogTypeExtension on DialogType {
  Color get color {
    switch (this) {
      case DialogType.cancel:
        return Color(0xFFFF9500);
      case DialogType.clear:
        return Color(0xFFFF0000);
      case DialogType.delete:
        return Color(0xFFFF3B30);
      case DialogType.exit:
        return Color(0xFF1D4380);
      case DialogType.confirmation:
        return Color(0xFF01A601);
      case DialogType.info:
        return Color(0xFFFF9500);
    }
  }

  String get image {
    String base = '${AppData.assets}dialog';
    switch (this) {
      case DialogType.cancel:
        return '$base/cancel.svg';
      case DialogType.clear:
        return '$base/clear.svg';
      case DialogType.delete:
        return '$base/delete.svg';
      case DialogType.exit:
        return '$base/exit.svg';
      case DialogType.confirmation:
        return '$base/confirmation.svg';
      case DialogType.info:
        return '$base/info.svg';
    }
  }

  String get btnText {
    switch (this) {
      case DialogType.cancel:
        return 'Confirm';
      case DialogType.clear:
        return 'Clear';
      case DialogType.delete:
        return 'Delete';
      case DialogType.exit:
        return 'Exit';
      case DialogType.confirmation:
        return 'Confirm';
      case DialogType.info:
        return 'OK';
    }
  }

  String get title {
    switch (this) {
      case DialogType.cancel:
        return "Cancel Action";
      case DialogType.clear:
        return "Clear Data";
      case DialogType.delete:
        return "Delete Item";
      case DialogType.exit:
        return "Exit App";
      case DialogType.confirmation:
        return "Confirmation";
      case DialogType.info:
        return "Information";
    }
  }

  String get message {
    switch (this) {
      case DialogType.cancel:
        return "Are you sure you want to cancel this action?";
      case DialogType.clear:
        return "Do you really want to clear all the entered data?";
      case DialogType.delete:
        return "Are you sure you want to delete this item? This action cannot be undone.";
      case DialogType.exit:
        return "Do you really want to exit the app?";
      case DialogType.confirmation:
        return "Are you sure you want to proceed with this action?";
      case DialogType.info:
        return "This is an information message";
    }
  }
}
