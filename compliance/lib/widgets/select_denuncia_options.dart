import 'package:flutter/material.dart';
import 'package:compliance/models/option_item.dart';
import 'package:compliance/theme/app_colors.dart';

/// Lista de opções (apenas a VIEW). Não guarda estado global.
/// Usa seleção global como um record (grupo, opção) => (int, int)?
class SelectDenunciaOptions extends StatelessWidget {
  final int groupIndex;
  final List<OptionItem> options;
  final (int, int)? selected;        // par (grupo, opção) global
  final ValueChanged<int> onChanged; // devolve o índice da opção escolhida

  const SelectDenunciaOptions({
    super.key,
    required this.groupIndex,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Marca somente se o grupo atual for o mesmo do selecionado global
    final int? groupValue =
        (selected != null && selected!.$1 == groupIndex) ? selected!.$2 : null;

    return Column(
      children: List.generate(options.length, (i) {
        return RadioListTile<int>(
          value: i,
          groupValue: groupValue,
          activeColor: AppColors.verdeOliva,
          title: Text(options[i].label),
          onChanged: (_) => onChanged(i),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          visualDensity: VisualDensity.compact,
        );
      }),
    );
  }
}
