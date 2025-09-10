import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';

class SubjectCardWidget extends StatelessWidget {
  final SubjectMdl mdl;
  const SubjectCardWidget({super.key, required this.mdl});
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${mdl.id}. ',
              style: textStyle(fontSize: 15.5, color: AppColors.black),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${mdl.section}. ',
                    style: textStyle(fontSize: 14.5, color: AppColors.violet),
                  ),
                  Text(
                    mdl.name,
                    style: textStyle(fontSize: 14.5, color: AppColors.blue),
                  ),
                ],
              ),
            ),
            Text(
              'Sets: ${mdl.sets.length}',
              style: textStyle(fontSize: 13, color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }
}
