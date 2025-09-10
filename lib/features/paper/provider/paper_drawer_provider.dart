import 'package:flutter/widgets.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';

class PaperDrawerProvider extends ChangeNotifier {
  final PaperProvider paperProvider;
  List<OptionType> countTypes;
  List<OptionType> countTypesAll = [
    OptionType.total,
    OptionType.selected,
    OptionType.unselected,
    OptionType.correctAnswer,
    OptionType.wrongAnswer,
  ];
  PaperDrawerProvider({required this.paperProvider})
    : countTypes = [
        OptionType.total,
        if (!paperProvider.isView) ...[
          OptionType.selected,
          OptionType.unselected,
        ],
        if (paperProvider.isView) ...[
          OptionType.correctAnswer,
          OptionType.wrongAnswer,
          OptionType.unAnswered,
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

  OptionType getCountType(QuesMdl mdl) {
    if (paperProvider.isView) {
      return mdl.isNotAns
          ? OptionType.unAnswered
          : mdl.userAnswer == mdl.answer
          ? OptionType.correctAnswer
          : OptionType.wrongAnswer;
    }
    return mdl.isNotAns ? OptionType.unselected : OptionType.selected;
  }

  String getCount(OptionType type) {
    List<QuesMdl> set = paperProvider.questions;
    switch (type) {
      case OptionType.total:
        return set.length.toString();
      case OptionType.selected:
        return set.where((e) => e.isAns).toList().length.toString();
      case OptionType.unselected:
        return set.where((e) => e.isNotAns).toList().length.toString();
      case OptionType.correctAnswer:
        return set.where((e) => e.isRightAns).toList().length.toString();
      case OptionType.wrongAnswer:
        return set
            .where((e) => e.isAns && !e.isRightAns)
            .toList()
            .length
            .toString();
      case OptionType.unAnswered:
        return set.where((e) => e.isNotAns).toList().length.toString();
    }
  }
}
