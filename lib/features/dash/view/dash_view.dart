// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypaper/common/dialog/dialog_type.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/common/widget/list_erd_widget.dart';
import 'package:mypaper/features/dash/enum/dash_bottom_type.dart';
import 'package:mypaper/features/dash/provider/dash_bottom_provider.dart';
import 'package:mypaper/features/dash/provider/dash_provider.dart';
import 'package:mypaper/features/dash/view/dash_bottom.dart';
import 'package:mypaper/features/dash/widget/dash_title_widget.dart';
import 'package:mypaper/features/dash/widget/error_ques_card_widget.dart';
import 'package:mypaper/features/dash/widget/subject_card_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/enum/dialog_type.dart';

class DashView extends StatefulWidget {
  const DashView({super.key});
  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  late DashProvider provider = context.read<DashProvider>();
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
          title: DashboardTitleWidget(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Selector<DashProvider, DashBottomType>(
            selector: (p0, p1) => p1.bottomType,
            builder: (context, type, w) {
              return type == DashBottomType.error
                  ? Selector<DashProvider, List<QuesMdl>?>(
                      selector: (p0, p1) => p1.erros,
                      builder: (context, list, child) {
                        return ListERDWidget<QuesMdl>(
                          onRefresh: () => provider.getErrorQuestion(),
                          title: 'No Question Found',
                          list: list,
                          builder: (mdl, index) =>
                              ErrorQuesCardWidget(questionMdl: mdl),
                        );
                      },
                    )
                  : Selector<DashProvider, List<SubjectMdl>?>(
                      selector: (p0, p1) => p1.subjects,
                      builder: (context, list, child) {
                        return ListERDWidget<SubjectMdl>(
                          onRefresh: () => provider.getSubject(),
                          title: 'No Subject Found',
                          list: list,
                          builder: (mdl, index) => InkWell(
                            onTap: () => provider.onTapCard(mdl),
                            child: SubjectCardWidget(mdl: mdl),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
        bottomNavigationBar: Provider(
          create: (con) => DashBottomProvider(context: context),
          child: DashBottom(),
        ),
      ),
    );
  }
}
