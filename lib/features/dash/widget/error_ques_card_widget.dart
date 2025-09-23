import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/features/dash/provider/dash_provider.dart';
import 'package:mypaper/features/paper/widget/ques_option_widget.dart';
import 'package:provider/provider.dart';

class ErrorQuesCardWidget extends StatelessWidget {
  final QuesMdl questionMdl;
  const ErrorQuesCardWidget({super.key, required this.questionMdl});
  @override
  Widget build(BuildContext context) {
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
          Selector<DashProvider, int>(
            selector: (p0, p1) => questionMdl.answer,
            builder: (context, ans, w) {
              return Column(
                children: List.generate(
                  questionMdl.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () => context.read<DashProvider>().onOptionChange(
                        questionMdl,
                        index,
                      ),
                      child: QuesOptionWidget(
                        option: questionMdl.options[index],
                        index: index,
                        type: index == questionMdl.answer
                            ? OptionType.correctAnswer
                            : OptionType.unselected,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: Text(questionMdl.options[questionMdl.answer])),
              SizedBox(
                width: 50,
                child: InkWell(
                  onTap: () => context.read<DashProvider>().onValidationChange(
                    questionMdl,
                  ),
                  child: Selector<DashProvider, bool>(
                    selector: (c, p) => questionMdl.isValid,
                    builder: (c, isValid, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 3),
                            child: Icon(
                              isValid ? Icons.verified : Icons.error,
                              size: 18,
                              color: isValid ? AppColors.green : AppColors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Path: ',
                  style: textStyle(
                    fontSize: 14,
                    color: AppColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: questionMdl.path,
                  style: textStyle(
                    fontSize: 14,
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
