import 'package:flutter/material.dart';
import 'package:mypaper/features/paper/provider/paper_drawer_provider.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/view/paper_drawer_view.dart';
import 'package:mypaper/features/paper/widget/ques_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PaperView extends StatefulWidget {
  const PaperView({super.key});
  @override
  State<PaperView> createState() => _PaperViewState();
}

class _PaperViewState extends State<PaperView> {
  late PaperProvider provider = context.read<PaperProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${provider.subjectMdl.name} : ${provider.setMdl.name}'),
      ),
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
                builder: (context, value, child) {
                  return ScrollablePositionedList.builder(
                    itemScrollController: provider.itemScrollController,
                    itemCount: provider.questions.length,
                    itemBuilder: (context, index) {
                      return QuesWidget(questionMdl: provider.questions[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
