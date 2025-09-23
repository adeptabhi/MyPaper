import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/features/dash/enum/dash_bottom_type.dart';
import 'package:mypaper/features/set/provider/set_provider.dart';
import 'package:provider/provider.dart';

class SetView extends StatefulWidget {
  const SetView({super.key});
  @override
  State<SetView> createState() => _SetViewState();
}

class _SetViewState extends State<SetView> {
  late SetProvider provider = context.read<SetProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sets - ${provider.subjectMdl.sets.length}'),
        actions: [modeRadioBtn(title: 'View Mode', value: true)],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        children: List.generate(provider.subjectMdl.sets.length, (index) {
          SetMdl set = provider.subjectMdl.sets[index];
          return InkWell(
            onTap: () => provider.onTapSet(context, set),
            child: CardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(set.file, style: textStyle(fontSize: 9)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text(
                            'Set ${set.id}:'.padRight(11),
                            style: textStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            set.name,
                            style: textStyle(
                              fontSize: 15.5,
                              color: AppColors.violet,
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
      ),
    );
  }

  Widget modeRadioBtn({required String title, required bool value}) {
    return Selector<SetProvider, DashBottomType>(
      selector: (p0, p1) => p1.bottomType,
      builder: (context, bottomType, w) {
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
                  value: bottomType == DashBottomType.tests,
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
