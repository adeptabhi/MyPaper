import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';

enum OptionType {
  unselected,
  selected,
  correctAnswer,
  wrongAnswer,
  unAnswered,
  total,
}

extension OptionTypeTheme on OptionType {
  Color get backgroundColor {
    switch (this) {
      case OptionType.unselected:
        return AppColors.white;
      case OptionType.selected:
        return AppColors.blue15;
      case OptionType.correctAnswer:
        return AppColors.green15;
      case OptionType.wrongAnswer:
        return AppColors.red15;
      case OptionType.unAnswered:
        return AppColors.grey15;
      case OptionType.total:
        return AppColors.pink15;
    }
  }

  Color get borderColor {
    switch (this) {
      case OptionType.unselected:
        return AppColors.black50;
      case OptionType.selected:
        return AppColors.blue50;
      case OptionType.correctAnswer:
        return AppColors.green50;
      case OptionType.wrongAnswer:
        return AppColors.red50;
      case OptionType.unAnswered:
        return AppColors.black50;
      case OptionType.total:
        return AppColors.pink50;
    }
  }

  Color get textColor {
    switch (this) {
      case OptionType.unselected:
        return AppColors.grey;
      case OptionType.selected:
        return AppColors.blue;
      case OptionType.correctAnswer:
        return AppColors.green;
      case OptionType.wrongAnswer:
        return AppColors.red;
      case OptionType.unAnswered:
        return AppColors.black;
      case OptionType.total:
        return AppColors.pink;
    }
  }

  String get label {
    switch (this) {
      case OptionType.selected:
        return 'Selected';
      case OptionType.unselected:
        return 'Unselected';
      case OptionType.correctAnswer:
        return 'Correct';
      case OptionType.wrongAnswer:
        return 'Wrong';
      case OptionType.unAnswered:
        return 'Unanswered';
      case OptionType.total:
        return 'Total';
    }
  }
}
