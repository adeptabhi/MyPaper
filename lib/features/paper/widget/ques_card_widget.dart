import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/common/widget/question_widget.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/widget/ques_option_widget.dart';
import 'package:provider/provider.dart';

class QuesCardWidget extends StatelessWidget {
  final QuesMdl quesMdl;
  const QuesCardWidget({super.key, required this.quesMdl});
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          QuestionWidget(quesMdl: quesMdl),
          ...List.generate(
            quesMdl.options.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: InkWell(
                onTap: () => context.read<PaperProvider>().onSelectOption(
                  quesMdl,
                  index,
                ),
                child: Selector<PaperProvider, int>(
                  selector: (p0, p1) => quesMdl.userAnswer,
                  builder: (context, value, child) {
                    return QuesOptionWidget(
                      option: quesMdl.options[index],
                      index: index,
                      type: context.read<PaperProvider>().getOptionType(
                        quesMdl,
                        index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Selector<PaperProvider, bool>(
                  selector: (c, p) => quesMdl.ansIsVisible,
                  builder: (c, isVisible, child) {
                    return InkWell(
                      onTap: () => context
                          .read<PaperProvider>()
                          .onVisibilityChange(quesMdl),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 3),
                            child: Icon(
                              isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 18,
                            ),
                          ),
                          if (isVisible)
                            Text(
                              'Option : ${String.fromCharCode(quesMdl.answer + 97)}',
                              style: textStyle(
                                color: AppColors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: InkWell(
                  onTap: () =>
                      context.read<PaperProvider>().onValidationChange(quesMdl),
                  child: Selector<PaperProvider, bool>(
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
        ],
      ),
    );
  }
}
