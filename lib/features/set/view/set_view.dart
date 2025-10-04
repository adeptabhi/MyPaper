// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/enum/set_status.dart';
import 'package:mypaper/common/model/set_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/features/set/provider/set_provider.dart';
import 'package:mypaper/features/set/widget/marquee_widget.dart';
import 'package:provider/provider.dart';

class SetView extends StatefulWidget {
  const SetView({super.key});
  @override
  State<SetView> createState() => _SetViewState();
}

class _SetViewState extends State<SetView> {
  late SetProvider provider = context.read<SetProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.setSetsStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.subjectMdl.name),
        actions: [modeRadioBtn(title: 'View Mode', value: true)],
      ),
      body: Column(
        children: [
          if (provider.sets.value.isNotEmpty)
            MarqueeWidget(
              items: provider.sets.value,
              height: 30,
              itemWidth: 100,
              speed: 1.5,
            ),

          Expanded(
            child: ValueListenableBuilder<List<SetMdl>>(
              valueListenable: provider.sets,
              builder: (context, list, widget) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                  children: List.generate(list.length, (index) {
                    SetMdl set = list[index];
                    return InkWell(
                      onTap: () => provider.onTapSet(context, set),
                      child: CardWidget(
                        bgColor: set.setStatus.backgroundColor,
                        borderColor: set.setStatus.borderColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Priority: ${set.isImp ? "High" : "Low"}",
                              style: textStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Text(
                                      'Set ${set.id}${set.subId == 96 ? '' : String.fromCharCode(set.subId)}:'
                                          .padRight(11),
                                      style: textStyle(
                                        fontWeight: FontWeight.w500,
                                        color: set.setStatus.textColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      set.name,
                                      style: textStyle(
                                        fontSize: 15.5,
                                        color: set.setStatus.textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget modeRadioBtn({required String title, required bool value}) {
    return Selector<SetProvider, bool>(
      selector: (p0, p1) => p1.isViewMode,
      builder: (context, isViewMode, w) {
        return SizedBox(
          height: 30,
          width: 120,
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 5),
              CheckboxTheme(
                data: CheckboxThemeData(
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    return states.contains(WidgetState.selected)
                        ? Colors.white
                        : Colors.white;
                  }),
                  checkColor: WidgetStateProperty.all<Color>(AppColors.green),
                  overlayColor: WidgetStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  side: const BorderSide(color: Colors.white, width: 0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Checkbox(
                  value: isViewMode,
                  onChanged: (newValue) => provider.setChangeMode(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
