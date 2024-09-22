import 'package:design_system/design_system.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class TractianLoadingShimmerWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const TractianLoadingShimmerWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return !isLoading ? child : Shimmer.fromColors(
      baseColor: TractianColors.gray200,
      highlightColor: TractianColors.whiteBrand,
      child: child,
    );
  }
}
