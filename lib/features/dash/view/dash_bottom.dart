import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/features/dash/enum/dash_bottom_type.dart';
import 'package:mypaper/features/dash/provider/dash_bottom_provider.dart';
import 'package:mypaper/features/dash/provider/dash_provider.dart';
import 'package:provider/provider.dart';

class DashBottom extends StatelessWidget {
  const DashBottom({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.blue,
      elevation: 10,
      shadowColor: AppColors.grey,
      height: 56,
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Selector<DashProvider, DashBottomType>(
        selector: (p0, p1) => p1.bottomType,
        builder: (context, type, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _itemBtn(context, type, DashBottomType.home),
              _itemBtn(context, type, DashBottomType.tests),
              _itemBtn(context, type, DashBottomType.error),
            ],
          );
        },
      ),
    );
  }

  Widget _itemBtn(
    BuildContext context,
    DashBottomType slct,
    DashBottomType type,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () => context.read<DashBottomProvider>().onTap(type),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Icon(
                type.icon,
                size: 33,
                color: slct == type
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(
              width: 63,
              height: 15,
              child: Text(
                textAlign: TextAlign.center,
                type.label,
                style: textStyle(
                  color: slct == type
                      ? AppColors.white
                      : AppColors.white.withValues(alpha: 0.7),
                  fontSize: 11.0,
                ).copyWith(height: 1.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
