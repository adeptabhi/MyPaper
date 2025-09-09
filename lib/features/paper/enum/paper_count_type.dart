import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';

enum PaperCountType { unselected, selected, correctAnswer, wrongAnswer, total }

extension PaperCountTypeTheme on PaperCountType {
  Color get backgroundColor {
    switch (this) {
      case PaperCountType.unselected:
        return AppColors.black15;
      case PaperCountType.selected:
        return AppColors.blue15;
      case PaperCountType.correctAnswer:
        return AppColors.green15;
      case PaperCountType.wrongAnswer:
        return AppColors.red15;
      case PaperCountType.total:
        return AppColors.pink15;
    }
  }

  Color get borderColor {
    switch (this) {
      case PaperCountType.unselected:
        return AppColors.white;
      case PaperCountType.selected:
        return AppColors.blue;
      case PaperCountType.correctAnswer:
        return AppColors.green;
      case PaperCountType.wrongAnswer:
        return AppColors.red;
      case PaperCountType.total:
        return AppColors.pink;
    }
  }

  Color get textColor {
    switch (this) {
      case PaperCountType.unselected:
        return AppColors.grey;
      case PaperCountType.selected:
        return AppColors.blue;
      case PaperCountType.correctAnswer:
        return AppColors.green;
      case PaperCountType.wrongAnswer:
        return AppColors.red;
      case PaperCountType.total:
        return AppColors.pink;
    }
  }

  String get label {
    switch (this) {
      case PaperCountType.selected:
        return 'Selected';
      case PaperCountType.unselected:
        return 'UnSelected';
      case PaperCountType.correctAnswer:
        return 'Correct';
      case PaperCountType.wrongAnswer:
        return 'Wrong';
      case PaperCountType.total:
        return 'Total';
    }
  }
}
