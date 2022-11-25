import 'package:flutter/material.dart';
import 'package:travin_app/ui/widget/shimmerwidget.dart';

class LoadingPopulerList extends StatefulWidget {
  LoadingPopulerList({Key? key}) : super(key: key);

  @override
  State<LoadingPopulerList> createState() => _LoadingPopulerListState();
}

class _LoadingPopulerListState extends State<LoadingPopulerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 145,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 30, bottom: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFECEEF2)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ShimmerWidget(
            height: 145,
            width: MediaQuery.of(context).size.width,
          ),
        ));
  }
}
