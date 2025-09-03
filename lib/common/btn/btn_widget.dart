import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';

class BtnWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final double radius;
  final double height;
  final double? width;
  final Color color;
  final EdgeInsets padding;
  const BtnWidget(
    this.text, {
    super.key,
    required this.onTap,
    this.radius = 5.0,
    this.height = 30,
    this.width,
    this.color = AppColors.blue,
    this.padding = EdgeInsets.zero,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(color),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
            ),
          ),
          child: Text(
            text,
            style: textStyle(fontSize: 16, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
