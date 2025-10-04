// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/enum/set_status.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/set_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_name.dart';

class SetProvider extends ChangeNotifier {
  SubjectMdl subjectMdl;
  SetProvider({required this.subjectMdl})
    : sets = subjectMdl.sets.where((e) => e.isImp).toList();

  bool isViewMode = false;
  List<SetMdl> sets = [];
  void setSetsStatus() async {
    var setsMdl = (await DB.inst.select(
      tblName: TableName.sets,
      where: 'path LIKE ?',
      whereArgs: ['${subjectMdl.path}%'],
      orderBy: 'id ASC',
      groupBy: 'path',
    )).map((e) => QuesMdl.fromJson(e)).toList();
    for (var mdl1 in setsMdl) {
      for (var mdl2 in subjectMdl.sets) {
        if (mdl1.path == subjectMdl.path + mdl2.file) {
          mdl2.setStatus = SetStatus.completed;
        }
      }
    }
    sets = [...subjectMdl.sets];
    notifyListeners();
  }

  void setChangeMode() {
    isViewMode = !isViewMode;
    notifyListeners();
  }

  void onTapSet(BuildContext context, SetMdl setMdl) async {
    List<QuesMdl> questions = (isViewMode
        ? (await DB.inst.select(
            tblName: TableName.sets,
            where: 'path=?',
            whereArgs: [subjectMdl.path + setMdl.file],
            orderBy: 'id ASC',
          )).map((e) => QuesMdl.fromJson(e)).toList()
        : await ApiService().questions(file: subjectMdl.path + setMdl.file));
    if (questions.isEmpty) {
      if (isViewMode) {
        snackBarMsg(context, 'Set ${setMdl.id}(${setMdl.name}): Not Attempted');
      }
    } else {
      await Navigator.pushNamed(
        context,
        RouteName.paper,
        arguments: PaperProvider(
          isView: isViewMode,
          setMdl: setMdl,
          subjectMdl: subjectMdl,
          questions: questions,
        ),
      );
      setSetsStatus();
    }
  }
}
