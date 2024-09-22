import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

part '../tractian_toggle_buttons.dart';

class TractianToggleButtonWidget extends StatelessWidget {
  final TractianToggleButtons settings;
  const TractianToggleButtonWidget({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final isActive = settings.isActive;
    final color =
        isActive ? TractianColors.whiteBrand : TractianColors.bodyText2;
    final textColor = mediumSm.customColor(color);
    final borderColor = isActive ? TractianColors.whiteBrand : TractianColors.gray200;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4),
        color: isActive ? TractianColors.blue50 : TractianColors.transparent,
      ),
      child: InkWell(
        onTap: settings.onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Row(
            children: [
              Icon(settings.icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(settings.title, style: textColor),
            ],
          ),
        ),
      ),
    );
  }
}
