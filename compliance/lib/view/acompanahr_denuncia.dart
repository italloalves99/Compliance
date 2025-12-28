import 'package:compliance/components/app_button.dart';
import 'package:compliance/components/input_card.dart';
import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/responsive_app_bart.dart';
import 'package:compliance/view/acompanhar_denuncias_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:compliance/theme/app_colors.dart';

class AcompanharDenuncia extends StatefulWidget {
  const AcompanharDenuncia({
    super.key,
    required this.onConsultar,   // o que fazer ao consultar
                 // ex.: LogoComponent(...)
    this.titulo = 'Acompanhar Denúncia',
  });

  final void Function(String protocolo) onConsultar;
  
  final String titulo;
  

  @override
  State<AcompanharDenuncia> createState() => _AcompanharDenunciaState();
}

class _AcompanharDenunciaState extends State<AcompanharDenuncia> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isValid = false;
  String? protocolo;
  String? _req(String? t) =>
      (t == null || t.trim().isEmpty) ? 'Obrigatório' : null;

  static final _re = RegExp(r'^DN-\d{4}-[A-Z0-9]{6,}$'); // ex.: DN-2025-XYZ123

  String? _validate(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Informe o número do protocolo';
    if (!_re.hasMatch(s)) return 'Formato inválido (ex.: DN-2025-XYZ123)';
    return null;
  }

  void _updateValidity(String v) {
    setState(() => _isValid = _validate(v) == null);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onConsultar(_controller.text.trim().toUpperCase());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    final borderColor = Colors.black.withOpacity(0.10);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      
      appBar: ResponsiveAppBar(title: 'Acompanhar Denúncia'),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            children: [
              
              const LogoComponent(size: 96, ),
              Center(
                child: Text(
                  widget.titulo,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.verdeOlivaEscuro,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              AppInputCard(
                label: 'Qual o número de protocolo da sua denúncia? ',
                leadingIcon: Icons.location_on_outlined,
                hintText: 'Ex.: DN-2025-XYZ123',
                textCapitalization: TextCapitalization.sentences,
                validator: _req,
                onChanged: (v) => protocolo = v,
              ),

              const SizedBox(height: 20),

              AppButton(
              text: "Iniciar a denúncia",
              type: AppButtonType.primary,
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AcompanharDenunciaStatus(
                    protocolo: 'DN-2025-XYZ123',
                    historico: const [
                      '14/09/2025 - 21:55:\nDenúncia Registrada',
                      '15/09/2025 - 08:05:\nDenúncia Visualizada',
                      '15/09/2025 - 10:00:\nEm análise do comitê de ética',
                    ],
                    // logo: LogoComponent(image: AssetImage('assets/logo.png')),
                  ),
                ),
              );
              },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

/// Força maiúsculas em tempo real
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
      composing: TextRange.empty,
    );
  }
}
