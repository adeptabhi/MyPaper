// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/features/dash/enum/bottom_type.dart';
import 'package:mypaper/features/set/provider/set_provider.dart';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_name.dart';

class DashProvider extends ChangeNotifier {
  BuildContext context;
  List<SubjectMdl>? subjects;
  DashProvider({required this.context});
  BottomType bottomType = BottomType.home;

  SubjectMdl? subjectMdl;
  List<QuesMdl>? quesErros;
  List<QuesMdl>? quesBookmarks;

  void getSubject() async {
    subjects = await ApiService().subjects();
    subjectMdl = subjects != null ? subjects![0] : null;
    notifyListeners();
  }

  void getBookmarkQuestion(SubjectMdl? mdl) async {
    if (mdl != null) {
      subjectMdl = mdl;
      quesBookmarks = (await DB.inst.select(
        tblName: TableName.sets,
        where: 'isBookmark=? AND path like ?',
        whereArgs: [1, "${mdl.path}%"],
        orderBy: 'path ASC , id ASC',
      )).map((e) => QuesMdl.fromJson(e)).toList();
    }
    notifyListeners();
  }

  void getErrorQuestion() async {
    quesErros = (await DB.inst.select(
      tblName: TableName.sets,
      where: 'isValid=?',
      whereArgs: [0],
      orderBy: 'path ASC , id ASC',
    )).map((e) => QuesMdl.fromJson(e)).toList();
    notifyListeners();
  }

  void onValidationChange(QuesMdl mdl) async {
    if (!mdl.isValid) {
      mdl.isValid = !mdl.isValid;
      await DB.inst.insert(tblName: TableName.sets, mdl: mdl);
      notifyListeners();
    }
  }

  void onOptionChange(QuesMdl mdl, int index) {
    if (!mdl.isValid) {
      mdl.answer = index;
      notifyListeners();
    }
  }

  void updateBottomType(BottomType type) async {
    bottomType = type;
    notifyListeners();
    if (bottomType == BottomType.error) {
      quesErros = null;
      getErrorQuestion();
    } else if (bottomType == BottomType.bookmark) {
      quesBookmarks = null;
      getBookmarkQuestion(subjectMdl);
    }
  }

  void onTapCard(SubjectMdl subjectMdl) async {
    if (subjectMdl.sets.isNotEmpty) {
      Navigator.pushNamed(
        context,
        RouteName.set,
        arguments: SetProvider(subjectMdl: subjectMdl),
      );
    } else {
      snackBarMsg(context, "Set Not Found");
    }
  }
}
