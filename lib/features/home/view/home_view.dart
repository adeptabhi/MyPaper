// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/dialog/dialog_type.dart';
import 'package:mypaper/features/home/provider/home_bottom_provider.dart';
import 'package:mypaper/features/home/view/home_bottom.dart';
import 'package:provider/provider.dart';

import '../../../common/enum/dialog_type.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        dialogType(
          context,
          type: DialogType.exit,
          onConfirm: () {
            SystemNavigator.pop();
          },
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(automaticallyImplyLeading: false, title: _Profile()),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  _Profile(),
              // Expanded(
              //   child: HomeExamCodeWidget(
              //     provider: context.read<HomeProvider>(),
              //   ),
              // ),
              SizedBox(height: 100),
            ],
          ),
        ),
        bottomNavigationBar: Provider(
          create: (con) => HomeBottomProvider(index: 'Home', context: context),
          child: HomeBottom(),
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();
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
                  'UPP Programmer',
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
