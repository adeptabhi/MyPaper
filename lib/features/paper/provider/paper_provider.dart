import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mypaper/common/dialog/dialog_type.dart';
import 'package:mypaper/common/enum/dialog_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/set_mdl.dart';
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

  void onSaveView(BuildContext context) {
    dialogType(
      context,
      type: DialogType.confirmation,
      message: 'Are you sure want to Save Paper??',
      onConfirm: () {
        Navigator.pop(context);
        Navigator.pop(context);
        isView = true;
        DB.inst.delete(
          tblName: TableName.sets,
          where: 'path=?',
          whereArgs: [subjectMdl.path + setMdl.file],
        );
        DB.inst.batchInsert(tblName: TableName.sets, mdlList: questions);
        notifyListeners();
      },
    );
  }
}
