import 'package:flutter/material.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PaperProvider extends ChangeNotifier {
  bool isView;
  SetMdl setMdl;
  SubjectMdl subjectMdl;
  List<QuesMdl> questions;
  PaperProvider({
    required this.isView,
    required this.setMdl,
    required this.subjectMdl,
    required this.questions,
  });

  final ItemScrollController itemScrollController = ItemScrollController();

  void onSelectOption(QuesMdl mdl, int index) {
    if (!isView) {
      if (mdl.userAnswer == index) {
        mdl.userAnswer = -1;
      } else {
        mdl.userAnswer = index;
      }
      notifyListeners();
    }
  }

  void onVisibilityChange(QuesMdl mdl) {
    mdl.ansIsVisible = !mdl.ansIsVisible;
    notifyListeners();
  }

  OptionType getOptionType(QuesMdl mdl, int index) {
    return isView
        ? (mdl.userAnswer == index && mdl.isAns
              ? (mdl.userAnswer == mdl.answer
                    ? OptionType.correctAnswer
                    : OptionType.wrongAnswer)
              : mdl.answer == index && mdl.isAns
              ? OptionType.correctAnswer
              : OptionType.unselected)
        : mdl.userAnswer == index
        ? OptionType.selected
        : OptionType.unselected;
  }

  void onViewResult() {
    isView = true;
    notifyListeners();
  }
}
