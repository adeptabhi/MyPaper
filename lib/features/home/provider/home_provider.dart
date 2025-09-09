// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/features/home/widget/dialog_set.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/routes/route_name.dart';

class HomeProvider extends ChangeNotifier {
  BuildContext context;
  HomeProvider({required this.context});
  List<SubjectMdl>? subjects;
  void getSubject() async {
    subjects = await ApiService().subjects();
    notifyListeners();
  }

  void onTapCard(SubjectMdl subjectMdl) async {
    showDialog(
      context: context,
      builder: (con) => DialogSet(
        sets: subjectMdl.sets,
        onTap: (setMdl) async {
          var questions = await ApiService().questions(
            file: subjectMdl.folder + setMdl.file,
          );
          Navigator.pushNamed(
            context,
            RouteName.paper,
            arguments: PaperProvider(
              isView: false,
              setMdl: setMdl,
              subjectMdl: subjectMdl,
              questions: questions,
            ),
          );
        },
      ),
    );
  }
}
