import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/responsive_app_bart.dart';
import 'package:flutter/material.dart';
import 'package:compliance/theme/app_colors.dart';

class AcompanharDenunciaStatus extends StatelessWidget {
  final String protocolo;           // ex.: "DN-2025-XYZ123"
  final List<String> historico;     // linhas já formatadas
              // opcional: LogoComponent(...)

  const AcompanharDenunciaStatus({
    super.key,
    required this.protocolo,
    required this.historico,
    
  });

  @override
  Widget build(BuildContext context) {
    const radius = 16.0;
    final verde = AppColors.verdeOlivaEscuro;
    final borderSoft = verde.withOpacity(.55);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // appBar: AppBar(
      //   title: Text('Status da Denúncia'),
      //   centerTitle: true,
      //   backgroundColor: AppColors.backgroundColor,
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      // ),
      appBar: ResponsiveAppBar(title: 'Status da Denúncia'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          children: [
            
            const LogoComponent(size: 96, ),
            
            const SizedBox(height: 24),

            // Cabeçalho + protocolo
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.5,
                  color: Colors.black.withOpacity(.85),
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: 'Status denúncia: '),
                  TextSpan(
                    text: protocolo,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: verde,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Caixa do histórico
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: borderSoft, width: 1.4),
              ),
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < historico.length; i++) ...[
                    Text(
                      historico[i],
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.35,
                        color: Colors.black87,
                      ),
                    ),
                    if (i != historico.length - 1) const SizedBox(height: 12),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Botão Voltar (pop para Home)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                style: FilledButton.styleFrom(
                  backgroundColor: verde,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
