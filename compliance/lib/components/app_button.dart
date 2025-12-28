import 'package:flutter/material.dart';
import 'package:compliance/theme/app_colors.dart';

enum AppButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AppButtonType type;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final commonStyle = TextStyle(
      fontWeight: FontWeight.w700,
    );

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: switch (type) {
        AppButtonType.primary => ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.verdeOliva,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: Text(text, style: commonStyle),
        ),
        AppButtonType.secondary => OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.verdeOliva, width: 1.6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            foregroundColor: AppColors.verdeOliva,
          ),
          child: Text(
            text,
            style: commonStyle,
            textAlign: TextAlign.center,
          ),
        ),
      },
    );
  }
}