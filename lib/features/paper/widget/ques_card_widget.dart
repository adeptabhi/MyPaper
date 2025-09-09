import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/widget/ques_option_widget.dart';
import 'package:mypaper/other/msg.dart';
import 'package:provider/provider.dart';

class QuesWidget extends StatelessWidget {
  final QuesMdl questionMdl;
  const QuesWidget({super.key, required this.questionMdl});
  @override
  Widget build(BuildContext context) {
    logError('name', msg: key);
    return CardWidget(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${questionMdl.id}. ',
                  style: textStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: questionMdl.question,
                  style: textStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          ...List.generate(
            questionMdl.options.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: InkWell(
                onTap: () =>
                    context.read<PaperProvider>().onSelect(questionMdl, index),
                child: Selector<PaperProvider, int>(
                  selector: (p0, p1) => questionMdl.userAnswer,
                  builder: (context, value, child) {
                    return QuesOptionWidget(
                      option: questionMdl.options[index],
                      index: index,
                      type: context.read<PaperProvider>().getOptionType(
                        questionMdl,
                        index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(questionMdl.options[questionMdl.answer]),
        ],
      ),
    );
  }
}
