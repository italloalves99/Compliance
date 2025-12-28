import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool showBorder;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.radius = 12,
    this.showBorder = true, // deixe true se quiser borda sutil
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7, // igual Variedade
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}