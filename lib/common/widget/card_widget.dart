import 'package:flutter/material.dart';
import 'package:mypaper/common/enum/status.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final Color? borderColor;
  final Status? status;
  final double radius;
  const CardWidget({
    super.key,
    required this.child,
    this.bgColor,
    this.borderColor,
    this.status,
    this.radius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: null,
      child: Card(
        margin: EdgeInsets.only(bottom: 5),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? status?.colorL2 ?? Color(0xFFE2E6F1),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 4,
        surfaceTintColor: bgColor ?? Color(0xFFFFFFFF),
        color: bgColor ?? status?.colorL3 ?? Color(0xFFFFFFFF),
        child: Padding(padding: const EdgeInsets.all(9.0), child: child),
      ),
    );
  }
}
