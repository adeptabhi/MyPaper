import 'package:flutter/material.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';

class SubjectCardWidget extends StatelessWidget {
  final SubjectMdl mdl;
  const SubjectCardWidget({super.key, required this.mdl});
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Text(
        '  ${mdl.id}. ${mdl.name}',
        style: textStyle(fontSize: 18).copyWith(height: 2),
      ),
    );
  }
}
