import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/subject_mdl.dart';

class DialogSet extends StatelessWidget {
  final List<SetMdl> sets;
  final void Function(SetMdl) onTap;
  const DialogSet({super.key, required this.sets, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Please Select Set',
                    style: textStyle(
                      fontSize: 14.5,
                      color: AppColors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  padding: EdgeInsets.all(0),
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, size: 20, color: AppColors.red),
                ),
              ],
            ),
            Divider(height: 1),
            SizedBox(height: 1),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: List.generate(sets.length, (index) {
                  SetMdl set = sets[index];
                  return InkWell(
                    onTap: () {
                      onTap(set);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0) Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Set ${set.id}:'.padRight(11),
                                  style: textStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.red,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: set.name,
                                  style: textStyle(
                                    fontSize: 15.5,
                                    color: AppColors.violet,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
