import 'package:flutter/widgets.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/features/paper/enum/paper_count_type.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/other/msg.dart';

class PaperDrawerProvider extends ChangeNotifier {
  final PaperProvider paperProvider;
  List<PaperCountType> countTypes;
  List<PaperCountType> countTypesAll = [
    PaperCountType.total,
    PaperCountType.selected,
    PaperCountType.unselected,
    PaperCountType.correctAnswer,
    PaperCountType.wrongAnswer,
  ];
  PaperDrawerProvider({required this.paperProvider})
    : countTypes = [
        PaperCountType.total,
        if (!paperProvider.paperMdl.isView) ...[
          PaperCountType.selected,
          PaperCountType.unselected,
        ],
        if (paperProvider.paperMdl.isView) ...[
          PaperCountType.correctAnswer,
          PaperCountType.wrongAnswer,
        ],
      ];

  void onTapIndex(int index) {
    final key = paperProvider.keys[index];
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
    logInfo('name', msg: 'setCall');
  }

  PaperCountType getCountType(QuesMdl mdl) {
    if (paperProvider.paperMdl.isView) {
      return mdl.isNotAns
          ? PaperCountType.unselected
          : mdl.userAnswer == mdl.answer
          ? PaperCountType.correctAnswer
          : PaperCountType.wrongAnswer;
    }
    return mdl.isNotAns ? PaperCountType.unselected : PaperCountType.selected;
  }

  String getCount(PaperCountType type) {
    switch (type) {
      case PaperCountType.total:
        return paperProvider.paperMdl.questions.length.toString();
      case PaperCountType.selected:
        return paperProvider.paperMdl.questions
            .where((e) => e.isAns)
            .toList()
            .length
            .toString();
      case PaperCountType.unselected:
        return paperProvider.paperMdl.questions
            .where((e) => e.isNotAns)
            .toList()
            .length
            .toString();
      case PaperCountType.correctAnswer:
        return paperProvider.paperMdl.questions
            .where((e) => e.isRightAns)
            .toList()
            .length
            .toString();
      case PaperCountType.wrongAnswer:
        return paperProvider.paperMdl.questions
            .where((e) => e.isAns && !e.isRightAns)
            .toList()
            .length
            .toString();
    }
  }
}
