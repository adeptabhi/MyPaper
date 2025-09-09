import 'package:flutter/material.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/enum/option_type.dart';

class QuesOptionWidget extends StatelessWidget {
  final String option;
  final int index;
  final OptionType type;
  const QuesOptionWidget({
    super.key,
    required this.option,
    required this.index,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(11).copyWith(right: 27.5),
          decoration: BoxDecoration(
            color: type.backgroundColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: type.borderColor, width: 0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${String.fromCharCode(97 + index)}.  ',
                style: textStyle(
                  color: type.textColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ).copyWith(height: 1.1),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 1, right: 1),
                  child: Text(
                    option,
                    style: textStyle(
                      color: type.textColor,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                    ).copyWith(height: 1.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
