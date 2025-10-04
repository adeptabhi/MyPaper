// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/common/btn/bottom_btn_widget.dart';
import 'package:mypaper/common/dialog/dialog_type.dart';
import 'package:mypaper/common/enum/ques_selection_type.dart';
import 'package:mypaper/common/ques_card/ques_card_provider.dart';
import 'package:mypaper/common/ques_card/ques_card_view.dart';
import 'package:mypaper/features/paper/provider/paper_drawer_provider.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/view/paper_drawer_view.dart';
import 'package:mypaper/features/paper/widget/paper_appbar_title.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../common/enum/dialog_type.dart';

class PaperView extends StatefulWidget {
  const PaperView({super.key});
  @override
  State<PaperView> createState() => _PaperViewState();
}

class _PaperViewState extends State<PaperView> {
  late PaperProvider provider = context.read<PaperProvider>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    provider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!provider.isView) {
          dialogType(
            context,
            type: DialogType.confirmation,
            onConfirm: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: PaperAppBarTitle()),
        endDrawer: ChangeNotifierProvider(
          create: (context) => PaperDrawerProvider(paperProvider: provider),
          child: PaperDrawerView(paperProvider: provider),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          child: Column(
            children: [
              Expanded(
                child: Selector<PaperProvider, bool>(
                  selector: (p0, p1) => p1.isView,
                  builder: (context, isView, child) {
                    return ChangeNotifierProvider(
                      create: (context) => QuesCardProvider(
                        type: isView
                            ? QuesSelectionType.isview
                            : QuesSelectionType.paper,
                      ),
                      child: ScrollablePositionedList.builder(
                        itemScrollController: provider.itemScrollController,
                        itemCount: provider.questions.length,
                        itemBuilder: (context, index) {
                          return QuesCardView(
                            quesMdl: provider.questions[index],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
