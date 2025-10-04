// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';
import 'package:mypaper/app/theme.dart';
import 'package:mypaper/common/model/set_mdl.dart';

class MarqueeWidget extends StatefulWidget {
  final List<SetMdl> items;
  final double height;
  final double itemWidth;
  final double speed;

  const MarqueeWidget({
    super.key,
    required this.items,
    this.height = 50,
    this.itemWidth = 100,
    this.speed = 1.0,
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      if (_scrollController.hasClients && widget.items.isNotEmpty) {
        _scrollPosition += widget.speed;
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
        }
        _scrollController.jumpTo(_scrollPosition);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      color: AppColors.red15,
      padding: EdgeInsets.only(left: 5, right: 5),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    'SET ${widget.items[index].id} : ${widget.items[index].name}',
                    style: textStyle(color: AppColors.red),
                  ),
                  SizedBox(width: 10),
                  Container(width: 2, color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
