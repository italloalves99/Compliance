import 'package:flutter/material.dart';
import 'package:compliance/models/option_item.dart';
import 'package:compliance/theme/app_colors.dart';
import 'package:compliance/widgets/select_denuncia_options.dart'; // mantenha seu path

/// Card do grupo (apenas apresentação + delega abrir/fechar)
class SelectDenuncia extends StatelessWidget {
  final int groupIndex;
  final String title;
  final List<OptionItem> options;
  final (int, int)? selected;              // seleção global (grupo, opção)
  final ValueChanged<int> onChanged;       // devolve índice da opção escolhida

  // >>> Novos para accordion <<<
  final bool expanded;                     // vem do pai
  final VoidCallback onExpandToggle;       // vem do pai

  const SelectDenuncia({
    super.key,
    required this.groupIndex,
    required this.title,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.expanded,          // <<< obrigatório
    required this.onExpandToggle,    // <<< obrigatório
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected != null && selected!.$1 == groupIndex;
    final String? selectedLabel = isSelected ? options[selected!.$2].label : null;

    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.verdeOliva, width: 1.5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Cabeçalho do card
            InkWell(
              onTap: onExpandToggle, // controle vem do pai
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          if (selectedLabel != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              selectedLabel,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.75),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 180),
                      turns: expanded ? 0.5 : 0.0,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.verdeOliva,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Conteúdo expandido (sem distorção)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, anim) {
                return ClipRect(
                  child: FadeTransition(
                    opacity: anim,
                    child: SizeTransition(
                      sizeFactor: anim,
                      axisAlignment: -1.0,
                      child: child,
                    ),
                  ),
                );
              },
              child: expanded
                  ? Padding(
                      key: const ValueKey('open'),
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                      child: SelectDenunciaOptions(
                        groupIndex: groupIndex,
                        options: options,
                        selected: selected,
                        onChanged: onChanged,
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('closed')),
            ),
          ],
        ),
      ),
    );
  }
}
