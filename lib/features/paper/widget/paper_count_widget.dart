import 'package:flutter/material.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/features/paper/enum/paper_count_type.dart';

class PaperCountWidget extends StatelessWidget {
  final PaperCountType type;
  final String value;
  final String head;
  final bool isCompleted;
  const PaperCountWidget({
    super.key,
    required this.value,
    this.head = '',
    required this.type,
    this.isCompleted = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: type.backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: type.borderColor, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (head.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                head.toString(),
                textAlign: TextAlign.center,
                style: textStyle(
                  color: type.textColor,
                  fontSize: isCompleted ? 14 : 11,
                  fontWeight: FontWeight.w500,
                ).copyWith(height: 1.1),
              ),
            ),
          Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: textStyle(
              color: type.textColor,
              fontSize: isCompleted ? 17 : 14,
              fontWeight: FontWeight.w500,
            ).copyWith(height: 1.1),
          ),
        ],
      ),
    );
  }
}
