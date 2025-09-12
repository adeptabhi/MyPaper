import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/other/date_time.dart';
import 'package:provider/provider.dart';

class PaperAppBarTitle extends StatelessWidget {
  const PaperAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<PaperProvider>();
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${provider.subjectMdl.name} : ${provider.setMdl.name}',
              style: textStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
          Positioned(
            top: 35,
            right: 0,
            left: 0,
            child: Center(
              child: Selector<PaperProvider, Duration>(
                selector: (p0, p1) => p1.duration,
                builder: (context, duration, child) =>
                    Text(dtFormatDuration(duration)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
