part of 'widgets/tractian_toggle_button_widget.dart';

class TractianToggleButtons {
  final String title;
  final bool isActive; 
  final IconData icon;
  final VoidCallback onTap;


  TractianToggleButtons({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

}