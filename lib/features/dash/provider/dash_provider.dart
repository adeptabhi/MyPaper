// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/features/dash/enum/dash_bottom_type.dart';
import 'package:mypaper/features/dash/widget/dialog_set.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/other/msg.dart';
import 'package:mypaper/routes/route_name.dart';

class DashProvider extends ChangeNotifier {
  BuildContext context;
  List<SubjectMdl>? subjects;
  DashProvider({required this.context});
  DashBottomType bottomType = DashBottomType.home;

  void getSubject() async {
    subjects = await ApiService().subjects();
    notifyListeners();
  }

  void updateBottomType(DashBottomType type) {
    bottomType = type;
    notifyListeners();
  }

  void onTapCard(SubjectMdl subjectMdl) async {
    if (subjectMdl.sets.isNotEmpty) {
      showDialog(
        context: context,
        builder: (con) => DialogSet(
          sets: subjectMdl.sets,
          onTap: (setMdl) async {
            List<QuesMdl> questions = (bottomType == DashBottomType.tests
                ? (await DB.inst.select(
                    tblName: TableName.sets,
                    where: 'path=?',
                    whereArgs: [subjectMdl.path + setMdl.file],
                  )).map((e) => QuesMdl.fromJson(e)).toList()
                : await ApiService().questions(
                    file: subjectMdl.path + setMdl.file,
                  ));
            if (questions.isEmpty) {
              toastMsg(
                bottomType == DashBottomType.tests
                    ? 'Set Not Attempted'
                    : "Set Not Found",
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
          },
        ),
      );
    }
  }
}
