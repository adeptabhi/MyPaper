import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/common/widget/card_widget.dart';
import 'package:mypaper/features/dash/enum/bottom_type.dart';
import 'package:mypaper/features/dash/provider/dash_provider.dart';
import 'package:provider/provider.dart';

class DashboardTitleWidget extends StatelessWidget {
  const DashboardTitleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hey, Vikas Yadav',
                  style: textStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'vy44664@gmail.com',
                  style: textStyle(fontSize: 8, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Sharpen Your Mind',
                  style: textStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              right: 10,
              child: Selector<DashProvider, BottomType>(
                selector: (p0, p1) => p1.bottomType,
                builder: (context, bottomType, w) {
                  DashProvider provider = context.read<DashProvider>();
                  return bottomType == BottomType.bookmark
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    height: 300,
                                    width: 300,
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Subject List: ",
                                          style: textStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Divider(),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                provider.subjects?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  provider.getBookmarkQuestion(
                                                    provider.subjects![index],
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: CardWidget(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          top: 5,
                                                          bottom: 5,
                                                        ),
                                                    child: Text(
                                                      '${provider.subjects![index].id}: ${provider.subjects![index].name}',
                                                      style: textStyle(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Selector<DashProvider, SubjectMdl?>(
                            selector: (p0, p1) => p1.subjectMdl,
                            builder: (context, sub, w) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    sub == null ? 'Select Subject' : sub.name,
                                    style: textStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(width: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.3),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
