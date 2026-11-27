import 'package:flutter/material.dart';
import 'api.dart';
import 'memoria.dart';
import 'pagina_pesquisa.dart';
import 'tema.dart';
import 'telas_estado.dart';
import 'widgets.dart';

class PaginaExplorar extends StatefulWidget {
  const PaginaExplorar({super.key});

  @override
  State<PaginaExplorar> createState() => _PaginaExplorarState();
}

class _PaginaExplorarState extends State<PaginaExplorar> {
  String estado = 'carregando'; // carregando, erro ou lista
  bool buscando = false;

  @override
  void initState() {
    super.initState();
    // Só busca na API se ainda não tiver receitas na memória
    if (receitasCarregadas.isNotEmpty) {
      estado = 'lista';
    } else {
      carregar();
    }
  }

  Future<void> carregar() async {
    if (buscando) return; // evita pedidos repetidos ao mesmo tempo
    buscando = true;
    setState(() => estado = 'carregando');

    try {
      receitasCarregadas = await buscarReceitas();
      estado = 'lista';
    } catch (e) {
      debugPrint('Erro ao carregar: $e');
      estado = 'erro';
    }

    buscando = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colher de Pau')),
      body: corpo(),
    );
  }

  Widget corpo() {
    if (estado == 'carregando') return const TelaCarregando();
    if (estado == 'erro') return TelaErro(aoTentar: carregar);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'O que vai pra panela hoje?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Pesquise uma receita pelo nome.'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaginaPesquisa()),
            ).then((_) => setState(() {}));
          },
          child: const Text('Pesquisar receita'),
        ),
        const SizedBox(height: 24),
        const Text('Receitas disponíveis', style: estiloTitulo),
        const Text('Selecione uma receita para ver o preparo.'),
        for (final r in receitasCarregadas)
          CardReceita(receita: r, aoAtualizar: () => setState(() {})),
      ],
    );
  }
}