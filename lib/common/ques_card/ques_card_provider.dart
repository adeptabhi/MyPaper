import 'package:flutter/material.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/enum/ques_selection_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';

//isview , paper, error , bookmark
class QuesCardProvider extends ChangeNotifier {
  QuesSelectionType type;
  QuesCardProvider({required this.type});
  void onVisibilityChange(QuesMdl mdl) {
    mdl.ansIsVisible = !mdl.ansIsVisible;
    notifyListeners();
  }

  void onBookmarkChange(QuesMdl quesMdl) async {
    quesMdl.isBookmark = !quesMdl.isBookmark;
    await DB.inst.insert(tblName: TableName.sets, mdl: quesMdl);
    notifyListeners();
  }

  void onValidationChange(QuesMdl quesMdl) async {
    quesMdl.isValid = !quesMdl.isValid;
    await DB.inst.insert(tblName: TableName.sets, mdl: quesMdl);
    notifyListeners();
  }

  void onSelectOption(QuesMdl mdl, int index) {
    if (type == QuesSelectionType.paper) {
      if (mdl.userAnswer == index) {
        mdl.userAnswer = -1;
      } else {
        mdl.userAnswer = index;
      }
    } else if (type == QuesSelectionType.error) {
      mdl.answer = index;
    }
    notifyListeners();
  }

  OptionType getOptionType(QuesMdl mdl, int index) {
    switch (type) {
      case QuesSelectionType.isview:
        return (mdl.userAnswer == index && mdl.isAns
            ? (mdl.userAnswer == mdl.answer
                  ? OptionType.correctAnswer
                  : OptionType.wrongAnswer)
            : mdl.answer == index
            ? mdl.isAns
                  ? OptionType.correctAnswer
                  : OptionType.unAnswered
            : OptionType.unselected);
      case QuesSelectionType.paper:
        return mdl.userAnswer == index
            ? OptionType.selected
            : OptionType.unselected;
      case QuesSelectionType.error || QuesSelectionType.bookmark:
        return mdl.answer == index
            ? OptionType.correctAnswer
            : OptionType.unselected;
    }
  }
}
