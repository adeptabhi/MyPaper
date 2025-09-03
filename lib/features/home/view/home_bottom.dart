import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/features/home/provider/home_bottom_provider.dart';
import 'package:provider/provider.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.blue,
      elevation: 10,
      shadowColor: AppColors.grey,
      height: 56,
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _itemBtn(context, "Home"),
          _itemBtn(context, "My Exam"),
        ],
      ),
    );
  }

  Widget _itemBtn(BuildContext context, String name) {
    return Expanded(
      child: InkWell(
        onTap: () => context.read<HomeBottomProvider>().onTap(name),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Icon(
                name == 'Home'
                    ? Icons.home
                    : name == 'My Exam'
                    ? Icons.quiz
                    : Icons.emoji_events,
                size: 33,
                color: context.read<HomeBottomProvider>().index == name
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(
              width: 63,
              height: 15,
              child: Text(
                textAlign: TextAlign.center,
                name,
                style: textStyle(
                  color: context.read<HomeBottomProvider>().index == name
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
