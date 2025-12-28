import 'package:flutter/material.dart';
import 'package:compliance/theme/app_colors.dart';

class AppInputSelectedCard<T> extends StatefulWidget {
  final String label;
  final IconData leadingIcon;
  final String hintText;
  final T? value;
  final List<T> options;
  final String Function(T) optionLabel;
  final ValueChanged<T?> onChanged;
  final VoidCallback? onClear;

  final bool enabled;
  final String? errorText;

  const AppInputSelectedCard({
    super.key,
    required this.label,
    required this.leadingIcon,
    required this.hintText,
    required this.value,
    required this.options,
    required this.optionLabel,
    required this.onChanged,
    this.onClear,
    this.enabled = true,
    this.errorText,
  });

  @override
  State<AppInputSelectedCard<T>> createState() => _AppInputSelectedCardState<T>();
}

class _AppInputSelectedCardState<T> extends State<AppInputSelectedCard<T>>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  void _toggle() {
    if (!widget.enabled) return;
    setState(() => _expanded = !_expanded);
  }

  void _select(T v) {
    widget.onChanged(v);
    setState(() => _expanded = false);
  }

  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    const height = 52.0;
    final borderColor = Colors.black.withOpacity(0.10);
    final textColor = widget.enabled ? Colors.black87 : Colors.black38;

    final hasValue = widget.value != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.65),
              letterSpacing: .2,
            ),
          ),
          const SizedBox(height: 6),

          // superfície estilo AppInputCard
          Opacity(
            opacity: widget.enabled ? 1 : .6,
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
                onTap: _toggle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    children: [
                      // linha principal (colapsada)
                      SizedBox(
                        height: height - 20, // compensa o padding vertical
                        child: Row(
                          children: [
                            Icon(widget.leadingIcon,
                                color: AppColors.verdeOlivaEscuro, size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                              hasValue
                                  ? widget.optionLabel(widget.value as T)
                                  : widget.hintText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400, // 👈 mais leve
                                color: hasValue
                                    ? textColor
                                    : textColor.withOpacity(0.45), // 👈 mais claro
                                fontStyle: hasValue ? FontStyle.normal : FontStyle.italic, // opcional
                              ),
                            ),
                            ),
                            const SizedBox(width: 8),
                            // clear ou chevron que gira
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              child: (hasValue && widget.onClear != null)
                                  ? InkWell(
                                      key: const ValueKey('clear'),
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        widget.onClear?.call();
                                        setState(() => _expanded = false);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.verdeOlivaEscuro,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.clear,
                                            color: Colors.white, size: 20),
                                      ),
                                    )
                                  : AnimatedRotation(
                                      key: const ValueKey('chev'),
                                      duration:
                                          const Duration(milliseconds: 180),
                                      turns: _expanded ? 0.5 : 0.0,
                                      child: const Icon(
                                          Icons.keyboard_arrow_down),
                                    ),
                            ),
                          ],
                        ),
                      ),

                      // área expandida (opções inline)
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        child: _expanded
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 6),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (final opt in widget.options)
                                      _ChoiceChipLike(
                                        label: widget.optionLabel(opt),
                                        selected: widget.value == opt,
                                        onTap: () => _select(opt),
                                      ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (widget.errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.errorText!,
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

/// Botãozinho estilo "chip" com borda, preenchendo quando selecionado.
class _ChoiceChipLike extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceChipLike({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selColor = AppColors.verdeOlivaEscuro;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? selColor.withOpacity(.10) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? selColor : Colors.black.withOpacity(.12),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? selColor : Colors.black87,
          ),
        ),
      ),
    );
  }
}
