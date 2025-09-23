import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/enum/option_type.dart';

class PaperCountWidget extends StatelessWidget {
  final OptionType type;
  final String value;
  final String head;
  final bool isCompleted;
  final bool isValid;
  const PaperCountWidget({
    super.key,
    required this.value,
    this.head = '',
    required this.type,
    this.isCompleted = false,
    this.isValid = true,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        if (!isValid)
          Positioned(
            top: 1,
            right: 1,
            child: Icon(Icons.error, size: 9, color: AppColors.red),
          ),
      ],
    );
  }
}
