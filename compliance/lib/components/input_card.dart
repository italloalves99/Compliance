import 'package:compliance/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputCard extends StatefulWidget {
  final String label;
  final IconData? leadingIcon;
  final Widget? trailing;
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final String? prefixText;
  final String? helperText;
  final int? minLines;
  final int? maxLines;

  const AppInputCard({
    super.key,
    required this.label,
    this.leadingIcon,
    this.trailing,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.prefixText,
    this.helperText,
    this.minLines,
    this.maxLines = 1,
  });

  @override
  State<AppInputCard> createState() => _AppInputCardState();
}

class _AppInputCardState extends State<AppInputCard> {
  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    final borderColor = Colors.black.withOpacity(0.10);

    final labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black.withOpacity(0.65),
      letterSpacing: .2,
    );

    final hintStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label
          Text(widget.label, style: labelStyle),
          const SizedBox(height: 6),

          // card estilo igual aos outros
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: TextFormField(
                  controller: widget.controller,
                  onTap: widget.onTap,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  textCapitalization: widget.textCapitalization,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Colors.black54,     // 👈 mais claro
                    fontWeight: FontWeight.w400, // 👈 mais leve
                    fontStyle: FontStyle.italic, // opcional (fica estilo "exemplo")
                  ),
                  prefixText: widget.prefixText,
                  border: InputBorder.none,
                  prefixIcon: widget.leadingIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4, right: 8),
                          child: Icon(
                            widget.leadingIcon,
                            size: 22,
                            color: Colors.black87, // ícone forte, diferente do hint
                          ),
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  suffixIcon: widget.trailing,
                ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ),

          if (widget.helperText != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.helperText!,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.black,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
