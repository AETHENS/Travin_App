import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.height, required this.width});
  final double height, width;
  final Color _baseColor = const Color(0xF5F0F5F6);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: const Color(0xF5F0F5F6),
        child: Container(
          height: height,
          width: width,
          color: _baseColor,
        ));
  }
}
