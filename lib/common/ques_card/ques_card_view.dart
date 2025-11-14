import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/ques_card/ques_card_provider.dart';
import 'package:mypaper/common/ques_card/question_widget.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/common/ques_card/ques_option_widget.dart';
import 'package:provider/provider.dart';

class QuesCardView extends StatelessWidget {
  final QuesMdl quesMdl;
  const QuesCardView({super.key, required this.quesMdl});
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
                onTap: () => context.read<QuesCardProvider>().onSelectOption(
                  quesMdl,
                  index,
                ),
                child: Selector<QuesCardProvider, int>(
                  selector: (p0, p1) => quesMdl.userAnswer,
                  builder: (context, value, child) {
                    return QuesOptionWidget(
                      option: quesMdl.options[index],
                      index: index,
                      type: context.read<QuesCardProvider>().getOptionType(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Selector<QuesCardProvider, bool>(
                  selector: (c, p) => quesMdl.ansIsVisible,
                  builder: (c, isVisible, child) {
                    return InkWell(
                      onTap: () => context
                          .read<QuesCardProvider>()
                          .onVisibilityChange(quesMdl),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Option : ${String.fromCharCode(quesMdl.answer + 97)}',
                                    style: textStyle(
                                      color: AppColors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (quesMdl.explanation.isNotEmpty)
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Explanation : ',
                                            style: textStyle(
                                              color: AppColors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: quesMdl.explanation,
                                            style: textStyle(
                                              color: AppColors.charcoal,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
              SizedBox(
                width: 50,
                child: InkWell(
                  onTap: () => context
                      .read<QuesCardProvider>()
                      .onValidationChange(quesMdl),
                  child: Selector<QuesCardProvider, bool>(
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
