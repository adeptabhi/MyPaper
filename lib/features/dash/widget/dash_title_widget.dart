import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';

class DashboardTitleWidget extends StatelessWidget {
  const DashboardTitleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hey, Vikas Yadav',
                  style: textStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'vy44664@gmail.com',
                  style: textStyle(fontSize: 8, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  //'Vikas Yadav',
                  'UPP Programmer',
                  //'******',
                  style: textStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
