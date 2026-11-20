import 'package:flutter/material.dart';
import 'dados.dart';
import 'tema.dart';
import 'widgets.dart';

class PaginaPesquisa extends StatefulWidget {
  const PaginaPesquisa({super.key});

  @override
  State<PaginaPesquisa> createState() => _PaginaPesquisaState();
}

class _PaginaPesquisaState extends State<PaginaPesquisa> {
  final campoBusca = TextEditingController();
  String? erro;
  String? termo;

  @override
  void dispose() {
    campoBusca.dispose();
    super.dispose();
  }

  void pesquisar() {
    // trim tira os espaços das pontas e o replaceAll junta os repetidos
    final texto = campoBusca.text.trim().replaceAll(RegExp(r'\s+'), ' ');

    if (texto.isEmpty) {
      setState(() {
        erro =
        'Digite o nome da receita. Só espaços não valem, tente “feijoada”.';
        termo = null;
      });
      return;
    }

    campoBusca.text = texto;
    setState(() {
      erro = null;
      termo = texto;
    });
  }

  void limpar() {
    campoBusca.clear();
    setState(() {
      erro = null;
      termo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = termo;
    final resultados = t == null
        ? <Receita>[]
        : receitas
        .where((r) => r.nome.toLowerCase().contains(t.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar receitas')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Qual receita você procura?', style: estiloTitulo),
          const SizedBox(height: 4),
          const Text('Você pode buscar por parte do nome da receita.'),
          const SizedBox(height: 16),
          TextField(
            controller: campoBusca,
            onSubmitted: (_) => pesquisar(),
            decoration: InputDecoration(
              labelText: 'Nome da receita',
              border: const OutlineInputBorder(),
              errorText: erro,
              errorMaxLines: 2,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: pesquisar,
            child: const Text('Buscar pelo nome'),
          ),
          if (t != null) ...[
            const SizedBox(height: 24),
            Text('Resultados para “$t”', style: estiloTitulo),
            if (resultados.isEmpty)
              TelaMensagem(
                icone: Icons.search_off,
                titulo: 'Nenhum resultado',
                texto: 'Não encontramos receitas para esse nome.\nTente outro termo.',
                botoes: [
                  ElevatedButton(
                    onPressed: () => setState(() => termo = null),
                    child: const Text('Alterar pesquisa'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ver todas as receitas'),
                  ),
                ],
              )
            else ...[
              const Text('Toque na receita para ver o preparo.'),
              for (final r in resultados)
                CardReceita(receita: r, aoAtualizar: () => setState(() {})),
              TextButton(
                onPressed: limpar,
                child: const Text('Limpar pesquisa'),
              ),
            ],
          ],
        ],
      ),
    );
  }
}