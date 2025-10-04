import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/btn/bottom_btn_widget.dart';
import 'package:mypaper/common/dialog/dialog_type.dart';
import 'package:mypaper/common/enum/dialog_type.dart';
import 'package:mypaper/common/enum/option_type.dart';
import 'package:mypaper/features/paper/provider/paper_drawer_provider.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/widget/paper_count_widget.dart';
import 'package:provider/provider.dart';

class PaperDrawerView extends StatelessWidget {
  final PaperProvider paperProvider;
  const PaperDrawerView({super.key, required this.paperProvider});
  @override
  Widget build(BuildContext context) {
    final provider = context.read<PaperDrawerProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Drawer(
        width: Platform.isWindows ? 350 : 250,
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status Overview',
                style: textStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Divider(),
              GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.1,
                ),
                itemCount: context
                    .read<PaperDrawerProvider>()
                    .countTypes
                    .length,
                itemBuilder: (context, index) {
                  var countType = provider.countTypes[index];
                  return PaperCountWidget(
                    value: provider.getCount(countType),
                    head: countType.label,
                    type: countType,
                  );
                },
              ),
              Text(
                'Question Summary',
                style: textStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: (paperProvider.questions).length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        provider.onTapIndex(context, index);
                      },
                      child: PaperCountWidget(
                        value: (index + 1).toString(),
                        isValid: paperProvider.questions[index].isValid,
                        type: provider.getCountType(
                          paperProvider.questions[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: BottomBtnWidget(
                    'Save Paper',
                    color: AppColors.green,
                    onTap: () => provider.paperProvider.onSaveView(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
