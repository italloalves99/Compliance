import 'package:flutter/material.dart';
import 'package:compliance/theme/app_assets.dart';

class LogoComponent extends StatelessWidget {
  final double size;

  const LogoComponent({
    super.key,
    this.size = 90,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Image.asset(AppAssets.logo), // usa o caminho centralizado
      ),
    );
  }
}