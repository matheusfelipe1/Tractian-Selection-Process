import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TractianCompaniesTileWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onTap;
  final String companyNamel;

  const TractianCompaniesTileWidget({
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.companyNamel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isLoading ? TractianColors.gray100 : TractianColors.blue50,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 32,
          ),
          child: Row(
            children: [
              TractianLoadingShimmerWidget(
                isLoading: isLoading,
                child: Icon(
                  size: 24,
                  TractianIcons.threeSquares,
                  color: TractianColors.whiteBrand,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: TractianLoadingShimmerWidget(
                  isLoading: isLoading,
                  child: Text(
                    companyNamel,
                    style: mediumLg.customColor(TractianColors.whiteBrand),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
