part of 'widgets/tractian_toggle_button_widget.dart';

class TractianToggleButtons {
  final String title;
  final bool isActive; 
  final IconData icon;
  final VoidCallback onTapActive;
  final VoidCallback onTapInactive;


  TractianToggleButtons({
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