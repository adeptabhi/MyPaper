import 'package:flutter/material.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/btn/btn_widget.dart';
import 'package:mypaper/common/btn/txt_status_btn.dart';
import 'package:mypaper/common/enum/dialog_type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mypaper/common/enum/status.dart';

Future<void> dialogType(
  BuildContext context, {
  required DialogType type,
  String? title,
  String? message,
  String? btnTitle,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(type.image, width: 48, height: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? type.title,
                      style: textStyle(
                        color: type.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message ?? type.message,
                      style: textStyle(
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TxtStatusBtn(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            right: 20,
                            left: 20,
                          ),
                          onTap: () => Navigator.pop(context),
                          label: 'Cancel',
                          status: Status.inprogress,
                        ),
                        BtnWidget(
                          btnTitle ?? type.btnText,
                          width: 90,
                          color: type.color,
                          onTap: onConfirm,
                          padding: EdgeInsets.only(left: 8),
                          height: 35.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
