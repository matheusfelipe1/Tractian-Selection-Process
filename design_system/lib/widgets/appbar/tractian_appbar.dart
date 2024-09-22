import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class TractianAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AppbarSettings appbarSettings;
  const TractianAppbar({
    super.key,
    required this.appbarSettings,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _buildTitle(),
      leading: _buildLeadingIcon(),
      automaticallyImplyLeading: false,
      backgroundColor: TractianColors.blue100,
    );
  }

  Widget _buildTitle() {
    return appbarSettings.hasTitle
        ? Text(
            appbarSettings.title!,
            style: regularLg.customColor(TractianColors.whiteBrand),
          )
        : appbarSettings.child ?? const SizedBox();
  }

  Widget? _buildLeadingIcon() {
    if (appbarSettings.leadingIcon == null) return null;
    return IconButton(
      onPressed: appbarSettings.onTapLeading,
      icon: Icon(
        size: 24,
        appbarSettings.leadingIcon,
        color: TractianColors.whiteBrand,
      ),
    );
  }
}
