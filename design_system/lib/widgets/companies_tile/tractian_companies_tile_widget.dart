import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TractianCompaniesTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String companyNamel;

  const TractianCompaniesTileWidget({
    super.key,
    required this.onTap,
    required this.companyNamel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TractianColors.blue50,
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
              Icon(
                size: 24,
                TractianIcons.threeSquares,
                color: TractianColors.whiteBrand,
              ),
              const SizedBox(width: 16),
              Text(
                companyNamel,
                style: mediumLg.customColor(TractianColors.whiteBrand),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
