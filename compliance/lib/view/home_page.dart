import 'package:compliance/components/app_button.dart';
import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/title.dart';
import 'package:compliance/theme/app_assets.dart';
import 'package:compliance/theme/app_colors.dart';
import 'package:compliance/theme/text_style.dart';
import 'package:compliance/view/acompanahr_denuncia.dart';
import 'package:compliance/view/selecionar_tema_denuncia.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo claro como no mock
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo + nome da empresa
                    const SizedBox(height: 8),
                    const LogoComponent(size: 96, ),
                    const SizedBox(height: 6),
                    AppTitle(),

                    const SizedBox(height: 24),

                    Text(
                      'CANAL DE DENÚNCIA ANÔNIMA',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.titlelarge.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.verdeOliva,
                        letterSpacing: 0.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.verdeOliva.withOpacity(0.6), width: 1.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      
                      child: Column(
                        children: [
                          // Texto igual ao do mock (com EXXA em negrito)
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: AppTextStyle.body.copyWith(height: 1.35, color: Colors.black87),
                              children: const [
                                TextSpan(text: 'Esse portal é exclusivo da empresa '),
                                TextSpan(text: AppAssets.nome_empresa, style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                  text:
                                      ' para uma comunicação segura e anônima, de condutas inapropriadas e antiéticas, '
                                      'que violem princípios e/ou legislações vigentes. As informações serão registradas '
                                      'e tratadas conforme cada situação sem conflitos de interesses.',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                        Column(
                        children: [
                          AppButton(
                            text: "Iniciar a denúncia",
                            type: AppButtonType.primary,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const SelecionarTemaDenuncia()),
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                          AppButton(
                            text: "Acompanhar denúncia já realizada",
                            type: AppButtonType.secondary,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AcompanharDenuncia(
                                  
                                    onConsultar: (protocolo) {
                                      // navegue para a tela de status, por exemplo:
                                      // Navigator.push(context, MaterialPageRoute(builder: (_) => StatusPage(protocolo: protocolo)));
                                    },
                                  ),
                                ),
                              );
                              // TODO: navegação
                            },
                          ),
                        ],
                      )
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}