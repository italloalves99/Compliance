import 'package:compliance/components/app_button.dart';
import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/responsive_app_bart.dart';
import 'package:compliance/components/title.dart';
import 'package:flutter/material.dart';
import 'package:compliance/theme/app_colors.dart';
import 'package:flutter/services.dart';

class DenunciaEnviadaPage extends StatelessWidget {
  final String protocolo;            // ex.: DN-2025-XYZ123
  final VoidCallback? onConcluir;    // ação ao tocar em "Concluir"
               // opcional: sua LogoComponent

  const DenunciaEnviadaPage({
    super.key,
    required this.protocolo,
    this.onConcluir,
    
  });

  @override
  Widget build(BuildContext context) {
    const radius = 16.0;
    final borderColor = AppColors.verdeOlivaEscuro;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: ResponsiveAppBar(title: 'Denúncia Enviada '),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 8),

            const LogoComponent(size: 96, ),

            const SizedBox(height: 20),

              Text(
                'Sua denúncia foi enviada com sucesso.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.verdeOlivaEscuro,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Guarde o código abaixo para acompanhar o status no nosso site.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.35,
                  color: Colors.black.withOpacity(.70),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 24),

              // Caixa do protocolo
              Material(
                color: Colors.white,
                elevation: 1.5,
                shadowColor: Colors.black.withOpacity(0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: BorderSide(color: borderColor, width: 1.4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 18,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        protocolo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .4,
                          color: borderColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(Icons.copy_rounded, color: borderColor),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: protocolo));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Código copiado'),
                              backgroundColor: borderColor,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

                SizedBox(height: 20),

              AppButton(
                          text: "Concluir",
                          type: AppButtonType.primary,
                          onPressed: onConcluir ?? () => Navigator.pop(context),
                        ),
              
            ],
          ),
        ),
      ),
    );
  }
}
