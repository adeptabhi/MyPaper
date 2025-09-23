// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/features/dash/enum/dash_bottom_type.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_name.dart';

class SetProvider extends ChangeNotifier {
  DashBottomType bottomType;
  SubjectMdl subjectMdl;
  SetProvider({required this.bottomType, required this.subjectMdl});

  void setChangeMode() {
    bottomType = bottomType.change;
    notifyListeners();
  }

  void onTapSet(BuildContext context, SetMdl setMdl) async {
    List<QuesMdl> questions = (bottomType == DashBottomType.tests
        ? (await DB.inst.select(
            tblName: TableName.sets,
            where: 'path=?',
            whereArgs: [subjectMdl.path + setMdl.file],
            orderBy: 'id ASC',
          )).map((e) => QuesMdl.fromJson(e)).toList()
        : await ApiService().questions(file: subjectMdl.path + setMdl.file));
    if (questions.isEmpty) {
      snackBarMsg(
        context,
        bottomType == DashBottomType.tests
            ? 'Set ${setMdl.id}(${setMdl.name}): Not Attempted'
            : "Set ${setMdl.id}(${setMdl.name}): Not Found ",
      );
    } else {
      Navigator.pushNamed(
        context,
        RouteName.paper,
        arguments: PaperProvider(
          isView: bottomType == DashBottomType.tests,
          setMdl: setMdl,
          subjectMdl: subjectMdl,
          questions: questions,
        ),
      );
    }
  }
}
