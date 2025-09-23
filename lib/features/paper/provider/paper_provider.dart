import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
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
  Duration duration = Duration(seconds: 0);
  Timer? timer;
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void startTimer() {
    if (!isView) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        duration += const Duration(seconds: 1);
        if (isView) timer.cancel();
        notifyListeners();
      });
    }
  }

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

  void onValidationChange(QuesMdl mdl) {
    mdl.isValid = !mdl.isValid;
    notifyListeners();
  }

  OptionType getOptionType(QuesMdl mdl, int index) {
    return isView
        ? (mdl.userAnswer == index && mdl.isAns
              ? (mdl.userAnswer == mdl.answer
                    ? OptionType.correctAnswer
                    : OptionType.wrongAnswer)
              : mdl.answer == index
              ? mdl.isAns
                    ? OptionType.correctAnswer
                    : OptionType.unAnswered
              : OptionType.unselected)
        : mdl.userAnswer == index
        ? OptionType.selected
        : OptionType.unselected;
  }

  void onViewResult() {
    isView = true;
    DB.inst.delete(
      tblName: TableName.sets,
      where: 'path=?',
      whereArgs: [subjectMdl.path + setMdl.file],
    );
    DB.inst.batchInsert(tblName: TableName.sets, mdlList: questions);
    notifyListeners();
  }
}
