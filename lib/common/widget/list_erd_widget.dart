import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/app_data.dart';
import 'package:mypaper/app/theme.dart';

class ListERDWidget<T> extends StatelessWidget {
  final Function()? onRefresh;
  final String? title;
  final List<T>? list;
  final Widget Function(T, int) builder;
  const ListERDWidget({
    super.key,
    this.onRefresh,
    this.title,
    required this.list,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return (onRefresh == null)
        ? widget(context)
        : RefreshIndicator(
            onRefresh: () => onRefresh!(),
            child: widget(context),
          );
  }

  Widget widget(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            shrinkWrap: true,
            children: [
              if (list != null && list!.isNotEmpty)
                ...List.generate(
                  list!.length,
                  (index) => builder(list![index], index),
                ),
              if (list != null && list!.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20.0),
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 55,
                  ),
                  child: Center(
                    child: Card(
                      color: AppColors.white,
                      child: Stack(
                        children: [
                          Image.asset(
                            '${AppData.assets}empty.png',
                            width: 200,
                            height: 190,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 15,
                            child: Center(
                              child: Text(
                                title ?? 'No Data Found',
                                style: textStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
