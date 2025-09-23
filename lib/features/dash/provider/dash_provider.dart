// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/features/dash/enum/dash_bottom_type.dart';
import 'package:mypaper/features/set/provider/set_provider.dart';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_name.dart';

class DashProvider extends ChangeNotifier {
  BuildContext context;
  List<SubjectMdl>? subjects;
  DashProvider({required this.context});
  DashBottomType bottomType = DashBottomType.home;
  List<QuesMdl>? erros;
  void getSubject() async {
    subjects = await ApiService().subjects();
    notifyListeners();
  }

  void getErrorQuestion() async {
    erros = (await DB.inst.select(
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

  void updateBottomType(DashBottomType type) async {
    bottomType = type;
    notifyListeners();
    if (bottomType == DashBottomType.error) {
      erros = null;
      getErrorQuestion();
    }
  }

  void onTapCard(SubjectMdl subjectMdl) async {
    if (subjectMdl.sets.isNotEmpty) {
      Navigator.pushNamed(
        context,
        RouteName.set,
        arguments: SetProvider(bottomType: bottomType, subjectMdl: subjectMdl),
      );
    } else {
      snackBarMsg(context, "Set Not Found");
    }
  }
}
