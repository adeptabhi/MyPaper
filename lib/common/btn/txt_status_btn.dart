import 'package:flutter/material.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/enum/status.dart';

class TxtStatusBtn extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final Status status;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const TxtStatusBtn({
    super.key,
    required this.onTap,
    required this.label,
    required this.status,
    this.width,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        margin: margin,
        padding:
            padding ??
            const EdgeInsets.only(top: 8, bottom: 8, right: 24, left: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: status.colorL2, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            softWrap: false,
            style: textStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: status.colorL1,
            ),
          ),
        ),
      ),
    );
  }
}
