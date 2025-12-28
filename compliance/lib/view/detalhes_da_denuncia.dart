import 'package:compliance/components/app_button.dart';
import 'package:compliance/components/date_picker_sheet.dart' show DatePickerSheet, AppDateInputCard;
import 'package:compliance/components/grau_certeza_card.dart';
import 'package:compliance/components/input_card.dart';
import 'package:compliance/components/input_selected_card.dart';
import 'package:compliance/components/logo_component.dart';
import 'package:compliance/components/responsive_app_bart.dart';
import 'package:compliance/components/title.dart';
import 'package:compliance/models/contrutor_date.dart';
import 'package:compliance/theme/app_colors.dart';
import 'package:compliance/view/termo_de_ciencia.dart';
import 'package:compliance/widgets/title_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetalhesDaDenuncia extends StatefulWidget {
  final String title;

  const DetalhesDaDenuncia({super.key, required this.title});

  @override
  State<DetalhesDaDenuncia> createState() => _DetalhesDaDenunciaState();
}

class _DetalhesDaDenunciaState extends State<DetalhesDaDenuncia> {
  // variáveis que vão receber os valores dos campos
  String? ticket;
  String? local;
  String? anteriormente;
  String? quando;
  String? autor;
  String? continua;
  String? testemunhas;
  String? detalhes;
  String? certeza;

  // validador padrão

    DataPesquisa _datafinal = DataPesquisa();
  DataPesquisa get datafinal => _datafinal;

  void setardatafinal(DateTime? data) {
    _datafinal = DataPesquisa(data: data);
    
  }

  Future<DateTime?> _pickDate(BuildContext context, DateTime initial) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2080),
    );
    return picked;
  }

  String? _req(String? t) =>
      (t == null || t.trim().isEmpty) ? 'Obrigatório' : null;

   // "Sim" ou "Não"
  
  bool submitted = false;

    final _namePtBrFormatter = FilteringTextInputFormatter.allow(
    // Letras A-Z, a-z e acentuadas (Latin-1), espaços e alguns sinais comuns em nomes/cargos
    RegExp(r"[0-9A-Za-zÀ-ÖØ-öø-ÿ\s,.\-’'()]"),
  );

  int? _grau;

  void _onSalvar() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TermoDeCiencia(local: local,),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      
      appBar: ResponsiveAppBar(title: widget.title),
          
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

              const LogoComponent(size: 96, ),

              

              const SizedBox(height: 20),

              const TextForm(title: 'Detalhes da Denúncia'),

              AppInputCard(
                label: 'Onde ocorreu o incidente?',
                leadingIcon: Icons.location_on_outlined,
                hintText: 'EX.: Setor, sala, cidade…',
                textCapitalization: TextCapitalization.sentences,
                validator: _req,
                onChanged: (v) => local = v,
              ),

              AppDateInputCard(
              label: 'Quando esse fato ocorreu?',
              value: datafinal.data,
              onPick: (initial) async {
                  final d = await _pickDate(context, initial);
                  if (d != null) setardatafinal(d);
                  setState(() {});
                  return d;
                },
              onClear: () {setardatafinal(null);
                  setState(() {});
                },
              ),

              AppInputCard(
                label: 'Quem cometeu o incidente? ',
                leadingIcon: Icons.person_outline,
                hintText: 'Ex.: João Silva, Financeiro, Analista',
                keyboardType: TextInputType.name,                  // melhora teclado/sugestões
                textCapitalization: TextCapitalization.words,      // capitaliza palavras
                inputFormatters: [_namePtBrFormatter],             // permite acentos e sinais
                validator: _req,
                onChanged: (v) => autor = v,
              ),

              AppInputSelectedCard<String>(
                label: 'Esse fato continua ocorrendo?',
                leadingIcon: Icons.repeat_on_outlined,
                hintText: 'Responda: Sim ou Não',
                value: continua,
                options: const ['Sim', 'Não'],
                optionLabel: (s) => s,
                onChanged: (v) => setState(() => continua = v),
                onClear: () => setState(() => continua = null),
                errorText: (submitted && (continua == null)) ? 'Obrigatório' : null,
              ),

                AppInputCard(
                  label:
                  'Descreva com o maior nível de detalhes possível o ocorrido:',
                  leadingIcon: Icons.description_outlined,
                  hintText: 'Conte tudo que lembrar…',
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  validator: _req,
                  onChanged: (v) => detalhes = v,
                ),

                GrauCertezaCard(
                  value: _grau,
                  onChanged: (v) => setState(() => _grau = v),
                ),

                AppInputCard(
                label: 'Voce já denunciou anteriormente ? ',
                leadingIcon: Icons.location_on_outlined,
                hintText: 'Informe o Protocolo',
                textCapitalization: TextCapitalization.sentences,
                validator: _req,
                onChanged: (v) => anteriormente = v,
              ),

              SizedBox(height: 20),

                AppButton(
                            text: "Continuar",
                            type: AppButtonType.primary,
                            onPressed:_onSalvar
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
