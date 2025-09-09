import 'package:mypaper/common/model/ques_mdl.dart';

class PaperNavMdl {
  bool isView;
  List<QuesMdl> questions;
  PaperNavMdl({this.isView = false, required this.questions});
}
