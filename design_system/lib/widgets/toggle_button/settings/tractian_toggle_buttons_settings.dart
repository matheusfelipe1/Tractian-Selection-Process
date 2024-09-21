import 'package:flutter/material.dart';

class TractianToggleButtonsSettings {
  final String title;
  final bool isActive; 
  final IconData icon;
  final VoidCallback onTapActive;
  final VoidCallback onTapInactive;


  TractianToggleButtonsSettings({
    required this.icon,
    required this.title,
    this.isActive = false,
    required this.onTapActive,
    required this.onTapInactive,
  });

  void onTap() {
    if (isActive) {
      onTapInactive();
    } else {
      onTapActive();
    }
  }
}