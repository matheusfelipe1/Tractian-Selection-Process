import 'package:flutter/material.dart';

class AppbarSettings {
  final Widget? child;
  final String? title;
  final IconData? leadingIcon;
  final VoidCallback? onTapLeading;

  const AppbarSettings({
    this.child,
    this.title,
    this.leadingIcon,
    this.onTapLeading,
  }) : assert(child != null || title != null, "Either child or title must be provided");
}
