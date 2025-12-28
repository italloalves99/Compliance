import 'package:compliance/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ResponsiveAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      scrolledUnderElevation: 0,
      title: AutoSizeText(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,       // só uma linha
        minFontSize: 14,   // limite mínimo da fonte
        overflow: TextOverflow.ellipsis, // adiciona "..." se mesmo assim não couber
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
