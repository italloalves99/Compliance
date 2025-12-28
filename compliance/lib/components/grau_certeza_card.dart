import 'package:compliance/components/input_selected_card.dart';
import 'package:flutter/material.dart';
import 'package:compliance/theme/app_colors.dart';

class GrauCertezaCard extends StatelessWidget {
  final int? value;
  final ValueChanged<int?> onChanged;

  const GrauCertezaCard({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppInputSelectedCard<int>(
      label: 'Qual o grau de certeza sobre o fato?',
      leadingIcon: Icons.verified_outlined,
      hintText: 'Selecione o nível de certeza',
      value: value,
      options: const [25, 50, 75, 100],
      optionLabel: (v) => switch (v) {
        25 => 'Baixa certeza (25%)',
        50 => 'Média (50%)',
        75 => 'Alta (75%)',
        100 => 'Total (100%)',
        _ => '$v%',
      },
      onChanged: onChanged,
      onClear: () => onChanged(null),
    );
  }
}
