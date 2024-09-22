import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TractianButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const TractianButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(TractianColors.blue100),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Text(
        label,
        style: mediumSm.customColor(TractianColors.whiteBrand),
      ),
    );
  }
}
