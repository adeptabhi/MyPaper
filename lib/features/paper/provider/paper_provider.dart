import 'package:flutter/material.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/features/paper/model/paper_nav_mdl.dart';

class PaperProvider extends ChangeNotifier {
  BuildContext context;
  PaperNavMdl paperMdl;
  PaperProvider({required this.context, required this.paperMdl});
  final ScrollController scrollController = ScrollController();
  List<GlobalKey> keys = [];

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void onSelect(QuesMdl mdl, int index) {
    if (mdl.userAnswer == index) {
      mdl.userAnswer = -1;
    } else {
      mdl.userAnswer = index;
    }
    notifyListeners();
  }

  OptionType getOptionType(QuesMdl mdl, int index) {
    return mdl.userAnswer == index
        ? OptionType.selected
        : OptionType.unselected;
  }
}
