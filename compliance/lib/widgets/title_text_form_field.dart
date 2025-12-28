import 'package:compliance/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TextForm extends StatelessWidget {
  final String title;
  const TextForm({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: AutoSizeText(
              title,
              maxLines: 1,
              minFontSize: 12,          // até onde pode reduzir
              stepGranularity: 0.5,     // passos mais suaves
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.verdeOlivaEscuro,
                fontStyle: FontStyle.italic,
                fontSize: 22,           // tamanho desejado quando couber
              ),
            ),
          ),
        ],
      ),
    );
  }
}
