import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypaper/features/paper/provider/paper_drawer_provider.dart';
import 'package:mypaper/features/paper/provider/paper_provider.dart';
import 'package:mypaper/features/paper/view/paper_drawer_view.dart';
import 'package:mypaper/features/paper/widget/ques_card_widget.dart';
import 'package:mypaper/other/msg.dart';
import 'package:provider/provider.dart';

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
    provider.keys = List.generate(
      provider.paperMdl.questions.length,
      (index) => GlobalObjectKey("q_${provider.paperMdl.questions[index].id}"),
    );
    List<String> da = [];
    for (var data in provider.keys) {
      da.add(data.toString());
    }

    //logInfo('vikasTest', msg: jsonEncode({"data": da}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paper')),
      endDrawer: ChangeNotifierProvider(
        create: (context) => PaperDrawerProvider(paperProvider: provider),
        child: PaperDrawerView(paperProvider: provider),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: provider.scrollController,
                shrinkWrap: true,
                itemCount: provider.paperMdl.questions.length,
                itemBuilder: (context, index) => QuesWidget(
                  key: GlobalKey(), //provider.keys[index],
                  questionMdl: provider.paperMdl.questions[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
