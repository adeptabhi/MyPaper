// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:mypaper/api/api_service.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/features/paper/model/paper_nav_mdl.dart';
import 'package:mypaper/routes/route_name.dart';

class HomeProvider extends ChangeNotifier {
  BuildContext context;
  HomeProvider({required this.context});
  List<SubjectMdl>? subjects;
  void getSubject() async {
    subjects = await ApiService().subjects();
    notifyListeners();
  }

  void getQuestion(SubjectMdl mdl) async {
    var questions = await ApiService().questions(file: mdl.file);
    Navigator.pushNamed(
      context,
      RouteName.paper,
      arguments: PaperNavMdl(questions: questions),
    );
  }
}
