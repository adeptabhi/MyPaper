import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/app_data.dart';

enum Status { all, pending, inprogress, completed, cancel }

extension StatusExtension on Status {
  bool equal(Status status) => this == status;
  String get label {
    switch (this) {
      case Status.all:
        return 'All';
      case Status.pending:
        return 'Pending';
      case Status.inprogress:
        return 'In-Progress';
      case Status.completed:
        return 'Completed';
      case Status.cancel:
        return 'Cancelled';
    }
  }

  Color get colorL1 {
    switch (this) {
      case Status.all:
        return AppColors.charcoal;
      case Status.pending:
        return AppColors.orange;
      case Status.inprogress:
        return AppColors.blue;
      case Status.completed:
        return AppColors.green;
      case Status.cancel:
        return AppColors.red;
    }
  }

  Color get colorL2 {
    switch (this) {
      case Status.all:
        return AppColors.charcoal50;
      case Status.pending:
        return AppColors.orange50;
      case Status.inprogress:
        return AppColors.blue50;
      case Status.completed:
        return AppColors.green50;
      case Status.cancel:
        return AppColors.red50;
    }
  }

  Color get colorL3 {
    switch (this) {
      case Status.all:
        return AppColors.charcoal20;
      case Status.pending:
        return AppColors.orange20;
      case Status.inprogress:
        return AppColors.blue20;
      case Status.completed:
        return AppColors.green20;
      case Status.cancel:
        return AppColors.red20;
    }
  }

  String get image {
    switch (this) {
      case Status.all:
        return '${AppData.assets}status/pending.svg';
      case Status.pending:
        return '${AppData.assets}status/pending.svg';
      case Status.inprogress:
        return '${AppData.assets}status/in_progress.svg';
      case Status.completed:
        return '${AppData.assets}status/accept.svg';
      case Status.cancel:
        return '${AppData.assets}status/cancel.svg';
    }
  }
}
