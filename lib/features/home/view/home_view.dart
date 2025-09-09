// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypaper/common/dialog/dialog_type.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/common/widget/list_erd_widget.dart';
import 'package:mypaper/features/home/provider/home_bottom_provider.dart';
import 'package:mypaper/features/home/provider/home_provider.dart';
import 'package:mypaper/features/home/view/home_bottom.dart';
import 'package:mypaper/features/home/widget/home_title_widget.dart';
import 'package:mypaper/features/home/widget/subject_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/enum/dialog_type.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeProvider provider = context.read<HomeProvider>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getSubject();
    });
  }

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: HomeTitleWidget(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Selector<HomeProvider, List<SubjectMdl>?>(
            selector: (p0, p1) => p1.subjects,
            builder: (context, list, child) {
              return ListERDWidget<SubjectMdl>(
                onRefresh: () => provider.getSubject(),
                title: 'No Subject Found',
                list: list,
                builder: (mdl, index) => InkWell(
                  onTap: () => provider.getQuestion(mdl),
                  child: SubjectCardWidget(mdl: mdl),
                ),
              );
            },
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
