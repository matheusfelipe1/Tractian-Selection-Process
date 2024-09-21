import 'package:design_system/widgets/appbar/settings/appbar_settings.dart';
import 'package:flutter/material.dart';

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
      title: const Text('Título do App'),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Ação ao pressionar o botão
          },
        ),
      ],
    );
  }
}
