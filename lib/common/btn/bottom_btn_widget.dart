import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart' show AppColors;
import 'package:mypaper/app/theme.dart';

class BottomBtnWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final double radius;
  final double height;
  final Color color;
  final EdgeInsets padding;
  const BottomBtnWidget(
    this.text, {
    super.key,
    required this.onTap,
    this.radius = 0.0,
    this.height = 45,
    this.color = AppColors.blue,
    this.padding = EdgeInsets.zero,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(color),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
            ),
          ),
          child: Text(
            text,
            style: textStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
