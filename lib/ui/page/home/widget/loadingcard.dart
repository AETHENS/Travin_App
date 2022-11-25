import 'package:flutter/material.dart';
import 'package:travin_app/ui/widget/shimmerwidget.dart';

class LoadingCard extends StatefulWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  State<LoadingCard> createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 166,
      // height: 219,
      // padding: EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFECEEF2)),
          borderRadius: BorderRadius.circular(7)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: ShimmerWidget(
          width: 166,
          height: 219,
        ),
      ),
    );
  }
}
