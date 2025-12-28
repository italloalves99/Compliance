import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/responsive_app_bart.dart';
import 'package:compliance/view/denuncia_enviada.dart';
import 'package:flutter/material.dart';
import 'package:compliance/theme/app_colors.dart';

/// Tela de Termo de Ciência.
/// Retorna `true` via Navigator.pop quando o usuário aceitar.
class TermoDeCiencia extends StatefulWidget {
  final String? local;
  const TermoDeCiencia({super.key,required this.local});

  @override
  State<TermoDeCiencia> createState() => _TermoDeCienciaState();
}

class _TermoDeCienciaState extends State<TermoDeCiencia> {
  bool _aceito = false;
  bool _expandido = false;

  void _concluir(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DenunciaEnviadaPage(
          protocolo: 'DN-2025-XYZ123',
           // ou seu LogoComponent(...)
          onConcluir: () => Navigator.of(context).popUntil((r) => r.isFirst),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    final borderColor = Colors.black.withOpacity(0.10);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // appBar: AppBar(
      //   title: const Text('Termo de Ciência'),
      //   centerTitle: true,
      //   elevation: 0,
      //   scrolledUnderElevation: 0, // não muda cor ao rolar
      //   backgroundColor: AppColors.backgroundColor,
      // ),
      appBar: ResponsiveAppBar(title: 'Termo de Ciência'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            // Cabeçalho
            const LogoComponent(size: 96, ),
            
              SizedBox(height: 20,),
              
            Text(
              'Leia com atenção antes de prosseguir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.verdeOlivaEscuro,
              ),
            ),
            const SizedBox(height: 10),

            // Card do termo
            Material(
              color: Colors.white,
              elevation: 1.5,
              shadowColor: Colors.black.withOpacity(0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: borderColor, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Termos e Condições',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.verdeOlivaEscuro,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedCrossFade(
                      crossFadeState: _expandido
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 200),
                      firstChild: _TrechoTermo(maxLines: 6),
                      secondChild: const _TrechoTermo(),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => setState(() => _expandido = !_expandido),
                        icon: Icon(_expandido
                            ? Icons.expand_less
                            : Icons.expand_more),
                        label:
                            Text(_expandido ? 'Mostrar menos' : 'Ler tudo'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Checkbox "Li e estou ciente"
            Material(
              color: Colors.white,
              elevation: 1.5,
              shadowColor: Colors.black.withOpacity(0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: borderColor, width: 1),
              ),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                title: const Text(
                  'Declaro que li, compreendi e estou ciente das informações acima.',
                  style: TextStyle(fontSize: 14.5),
                ),
                value: _aceito,
                onChanged: (v) => setState(() => _aceito = !_aceito),
                checkboxShape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                activeColor: AppColors.verdeOlivaEscuro,
              ),
            ),

            const SizedBox(height: 20),

            // Ações
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed:  _aceito ? _concluir : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.verdeOlivaEscuro,
                      disabledBackgroundColor:
                          AppColors.verdeOlivaEscuro.withOpacity(.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Aceitar e continuar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Bloco de texto do termo (com bullets e parágrafos).
class _TrechoTermo extends StatelessWidget {
  final int? maxLines; // quando definido, limita as linhas para "preview"
  const _TrechoTermo({this.maxLines});

  @override
  Widget build(BuildContext context) {
    final text = '''
Este termo destina-se a informar sobre o tratamento dos dados e o uso do canal de denúncias.

• As informações fornecidas serão analisadas pela área responsável, seguindo políticas internas e legislação aplicável.
• Você pode optar por permanecer anônimo. Caso inclua dados pessoais, eles serão utilizados exclusivamente para contato e esclarecimentos.
• Não compartilhe dados sensíveis desnecessários. Utilize linguagem objetiva e fatos observáveis.
• A denúncia poderá gerar registros internos para fins de auditoria e conformidade.

Ao prosseguir, você afirma estar ciente destes pontos e concorda com o envio das informações.
''';

    final style = TextStyle(
      fontSize: 14.5,
      height: 1.35,
      color: Colors.black.withOpacity(0.85),
      fontWeight: FontWeight.w500,
    );

    if (maxLines != null) {
      return Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }
    return Text(text, style: style);
  }
}
