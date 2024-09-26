import 'package:flutter/material.dart';
import 'package:design_system/styles/tractian_fonts.dart';
import 'package:design_system/styles/tractian_colors.dart';

class TractianTextFieldWidget extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController controller;

  const TractianTextFieldWidget({
    super.key,
    this.onChanged,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 14,
      autocorrect: false,
      onChanged: onChanged,
      controller: controller,
      cursorColor: TractianColors.gray500,
      style: regularSm.customColor(TractianColors.bodyText2),
      onTapOutside: (_) {
        FocusScope.of(context).focusedChild?.unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.zero,
        fillColor: TractianColors.gray100,
        constraints: const BoxConstraints(maxHeight: 32),
        hintStyle: regularSm.customColor(TractianColors.gray500),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
        prefixIcon: const Icon(
          size: 14,
          Icons.search,
          color: TractianColors.gray500,
        ),
      ),
    );
  }
}
