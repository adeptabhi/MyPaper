import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/common/widget/question_widget.dart';
import 'package:mypaper/features/dash/provider/dash_provider.dart';
import 'package:mypaper/features/paper/widget/ques_option_widget.dart';
import 'package:provider/provider.dart';

class DashQuesCardWidget extends StatelessWidget {
  final bool isError;
  final QuesMdl quesMdl;
  const DashQuesCardWidget({
    super.key,
    required this.isError,
    required this.quesMdl,
  });
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          QuestionWidget(quesMdl: quesMdl),
          Selector<DashProvider, int>(
            selector: (p0, p1) => quesMdl.answer,
            builder: (context, ans, w) {
              return Column(
                children: List.generate(
                  quesMdl.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        if (isError) {
                          context.read<DashProvider>().onOptionChange(
                            quesMdl,
                            index,
                          );
                        }
                      },
                      child: QuesOptionWidget(
                        option: quesMdl.options[index],
                        index: index,
                        type: index == quesMdl.answer
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
              Expanded(child: Text(quesMdl.options[quesMdl.answer])),
              if (isError)
                SizedBox(
                  width: 50,
                  child: InkWell(
                    onTap: () => context
                        .read<DashProvider>()
                        .onValidationChange(quesMdl),
                    child: Selector<DashProvider, bool>(
                      selector: (c, p) => quesMdl.isValid,
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
                                color: isValid
                                    ? AppColors.green
                                    : AppColors.red,
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
                  text: quesMdl.path,
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
