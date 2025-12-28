import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/responsive_app_bart.dart';
import 'package:compliance/view/detalhes_da_denuncia.dart';
import 'package:compliance/widgets/select_denuncia.dart';
import 'package:compliance/widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:compliance/models/option_item.dart';
import 'package:compliance/theme/app_colors.dart';
// Se quiser usar seu botão padrão:
// import 'package:compliance/components/app_button.dart';

class SelecionarTemaDenuncia extends StatefulWidget {
  const SelecionarTemaDenuncia({super.key});

  @override
  State<SelecionarTemaDenuncia> createState() =>
      _SelecionarTemaDenunciaState();
}

class _SelecionarTemaDenunciaState extends State<SelecionarTemaDenuncia> {
  // seu mapa fixo (não muda)
  final Map<String, List<OptionItem>> _selecao = {
    'Conduta': [
      const OptionItem('Assédio Moral'),
      const OptionItem('Assédio Sexual'),
      const OptionItem('Agressão Física'),
      const OptionItem('Discriminação (Religiosa, Sexual ou Racismo)'),
    ],
    'Descumprimento de Normas e Legislações': [
      const OptionItem('Políticas Internas'),
      const OptionItem('Legislação Ambiental'),
      const OptionItem('Legislação Trabalhista'),
    ],
    'Sigilo de Informações': [
      const OptionItem('Uso indevido de informações privilegiadas'),
      const OptionItem('Vazamento de dados confidenciais'),
    ],
    'Atos ilícitos e conflitos de interesses': [
      const OptionItem('Fraude'),
      const OptionItem('Corrupção'),
      const OptionItem('Roubo, Furto ou desvios de produtos'),
      const OptionItem('Conflito de Interesses'),
    ],
  };

  /// Seleção ÚNICA global: (índice do grupo, índice da opção)
  (int, int)? _selected;
  int? _expandedIndex;
      void _onSalvar() {
      if (_selected == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma opção')),
        );
        return;
      }

      final entries = _selecao.entries.toList();
      final grupo = entries[_selected!.$1].key;
      final opcao = entries[_selected!.$1].value[_selected!.$2].label;

      // valor que você vai passar
      // final textoEscolhido = "$grupo: $opcao";
      final OpcaoEscolhido = "$opcao";

      // navegação para próxima tela passando a string
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetalhesDaDenuncia(title: OpcaoEscolhido),
        ),
      );
    }
@override
Widget build(BuildContext context) {
  final entries = _selecao.entries.toList();

  return Scaffold(
    backgroundColor: AppColors.backgroundColor,
    // appBar: AppBar(
    //   backgroundColor: AppColors.backgroundColor,
    //   title: const Text(''),
    //   scrolledUnderElevation: 0),
    appBar: ResponsiveAppBar(title: ''),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Logo no topo
          const Center(
            child:  LogoComponent(size: 96, ),
          ),
          const SizedBox(height: 16),
      
          const TextForm(title: 'Selecione o tema da denúncia'),
          
          const SizedBox(height: 20),
      
          // Lista de cards
          for (var g = 0; g < entries.length; g++)
            SelectDenuncia(
              groupIndex: g,
              title: entries[g].key,
              options: entries[g].value,
              selected: _selected,
              expanded: _expandedIndex == g,
              onExpandToggle: () {
                setState(() {
                  _expandedIndex = (_expandedIndex == g) ? null : g;
                });
              },
              onChanged: (optIndex) => setState(() => _selected = (g, optIndex)),
            ),
      
          const SizedBox(height: 20),
      
          // Botão Continuar
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _onSalvar,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.verdeOliva,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
