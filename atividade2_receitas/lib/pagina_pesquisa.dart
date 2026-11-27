import 'package:flutter/material.dart';
import 'api.dart';
import 'receita.dart';
import 'tema.dart';
import 'telas_estado.dart';
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
  String estado = 'carregando'; // carregando, falha ou pronto
  bool buscando = false;
  List<Receita> resultados = [];

  Future<void> pesquisar() async {
    if (buscando) return; // evita pesquisas repetidas ao mesmo tempo

    // trim tira os espaços das pontas e o replaceAll junta os repetidos
    final texto = campoBusca.text.trim().replaceAll(RegExp(r'\s+'), ' ');

    // Consulta vazia ou só com espaços não chama a API
    if (texto.isEmpty) {
      setState(() {
        erro = 'Digite o nome da receita. Só espaços não valem, tente “pizza”.';
        termo = null;
      });
      return;
    }

    campoBusca.text = texto;
    buscando = true;
    setState(() {
      erro = null;
      termo = texto;
      estado = 'carregando';
    });

    try {
      resultados = await buscarReceitas(termo: texto);
      estado = 'pronto';
    } catch (e) {
      debugPrint('Erro ao pesquisar: $e');
      estado = 'falha';
    }

    buscando = false;
    if (mounted) setState(() {});
  }

  void limpar() {
    campoBusca.clear();
    setState(() {
      erro = null;
      termo = null;
    });
  }

  Widget resultado() {
    if (estado == 'carregando') return const TelaCarregando();
    if (estado == 'falha') return TelaErro(aoTentar: pesquisar);

    if (resultados.isEmpty) {
      return TelaMensagem(
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
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Toque na receita para ver o preparo.'),
        for (final r in resultados)
          CardReceita(receita: r, aoAtualizar: () => setState(() {})),
        Center(
          child: TextButton(
            onPressed: limpar,
            child: const Text('Limpar pesquisa'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: buscando ? null : pesquisar,
            child: const Text('Buscar pelo nome'),
          ),
          if (termo != null) ...[
            const SizedBox(height: 24),
            Text('Resultados para “$termo”', style: estiloTitulo),
            resultado(),
          ],
        ],
      ),
    );
  }
}
