import 'package:flutter/widgets.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/features/paper/enum/paper_count_type.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';

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
        if (!paperProvider.isView) ...[
          PaperCountType.selected,
          PaperCountType.unselected,
        ],
        if (paperProvider.isView) ...[
          PaperCountType.correctAnswer,
          PaperCountType.wrongAnswer,
        ],
      ];

  void onTapIndex(BuildContext context, int index) {
    paperProvider.itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
    Navigator.pop(context);
  }

  PaperCountType getCountType(QuesMdl mdl) {
    if (paperProvider.isView) {
      return mdl.isNotAns
          ? PaperCountType.unselected
          : mdl.userAnswer == mdl.answer
          ? PaperCountType.correctAnswer
          : PaperCountType.wrongAnswer;
    }
    return mdl.isNotAns ? PaperCountType.unselected : PaperCountType.selected;
  }

  String getCount(PaperCountType type) {
    List set = paperProvider.questions;
    switch (type) {
      case PaperCountType.total:
        return set.length.toString();
      case PaperCountType.selected:
        return set.where((e) => e.isAns).toList().length.toString();
      case PaperCountType.unselected:
        return set.where((e) => e.isNotAns).toList().length.toString();
      case PaperCountType.correctAnswer:
        return set.where((e) => e.isRightAns).toList().length.toString();
      case PaperCountType.wrongAnswer:
        return set
            .where((e) => e.isAns && !e.isRightAns)
            .toList()
            .length
            .toString();
    }
  }
}
