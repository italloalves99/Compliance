import 'package:compliance/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateInputCard extends StatelessWidget {
  final String label;
  final DateTime? value;
  final Future<DateTime?> Function(DateTime) onPick;
  final VoidCallback onClear;

  final bool enabled;
  final String? errorText;
  final IconData icon;
  final String placeholderText;

  const AppDateInputCard({
    super.key,
    required this.label,
    required this.value,
    required this.onPick,
    required this.onClear,
    this.enabled = true,
    this.errorText,
    this.icon = Icons.calendar_month,
    this.placeholderText = 'Selecione a Data',
  });

  Future<void> _openPicker() async {
    final initial = value ?? DateTime.now();
    await onPick(initial);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final df = DateFormat('dd/MM/yyyy');

    // === estilos iguais aos do AppInputCard ===
    const radius = 12.0;
    const height = 52.0;
    final borderColor = Colors.black.withOpacity(0.10); // borda suave
    final hoverColor = Colors.black.withOpacity(0.03);
    final textColor = enabled ? Colors.black87 : Colors.black38;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label (mesma tipografia)
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.65),
              letterSpacing: .2,
            ),
          ),
          const SizedBox(height: 6),

          // superfície do input (igual aos textuais)
          Opacity(
            opacity: enabled ? 1 : .6,
            child: Material(
              color: Colors.white,
              elevation: 1.5,
              shadowColor: Colors.black.withOpacity(0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: borderColor, width: 1),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(radius),
                onTap: enabled ? _openPicker : null,
                hoverColor: hoverColor,
                child: SizedBox(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Icon(icon, color: Colors.black, size: 22),
                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                          hasValue ? df.format(value!) : placeholderText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400, // 👈 mais leve
                            color: hasValue
                                ? textColor
                                : textColor.withOpacity(0.45), // 👈 mais claro
                            fontStyle: hasValue ? FontStyle.normal : FontStyle.italic, // 👈 opcional
                          ),
                        ),),
                        const SizedBox(width: 8),

                        // trailing (limpar / abrir)
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 150),
                            transitionBuilder: (c, a) =>
                                FadeTransition(opacity: a, child: c),
                            layoutBuilder: (current, previous) => Stack(
                              alignment: Alignment.center,
                              children: [...previous, if (current != null) current],
                            ),
                            child: hasValue
                                ? InkWell(
                                    key: const ValueKey('clear'),
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: enabled ? onClear : null,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.verdeOlivaEscuro,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.clear,
                                          color: Colors.white, size: 20),
                                    ),
                                  )
                                : IconButton(
                                    key: const ValueKey('open'),
                                    onPressed: enabled ? _openPicker : null,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              errorText!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
