import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/db/db.dart';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/other/msg.dart';

class QuestionWidget extends StatelessWidget {
  final QuesMdl quesMdl;
  const QuestionWidget({super.key, required this.quesMdl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: quesMdl.toString()));
        snackBarMsg(context, 'Copied Question with Option');
      },
      onTap: () {
        Clipboard.setData(ClipboardData(text: quesMdl.question));
        snackBarMsg(context, 'Copied Question');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${quesMdl.id}. ',
                style: textStyle(
                  fontSize: 14,
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  quesMdl.question,
                  style: textStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return InkWell(
                    onTap: () async {
                      quesMdl.isBookmark = !quesMdl.isBookmark;
                      setState(() {});
                      await DB.inst.insert(
                        tblName: TableName.sets,
                        mdl: quesMdl,
                      );
                    },
                    child: SizedBox(
                      width: 50,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          quesMdl.isBookmark
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
