// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });
  final Widget child;
  final Color? baseColor, highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor ?? const Color.fromARGB(255, 212, 212, 212),
        highlightColor:
            highlightColor ?? const Color.fromARGB(112, 255, 255, 255),
        child: child);
  }
}
